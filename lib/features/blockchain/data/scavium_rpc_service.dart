import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/core/utils/rpc_url_validator.dart';
import 'package:scavium_wallet/features/assets/domain/token_info.dart';
import 'package:scavium_wallet/features/blockchain/domain/network_info.dart';
import 'package:scavium_wallet/features/blockchain/domain/transaction_send_result.dart';
import 'package:scavium_wallet/features/wallet/data/wallet_repository_impl.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_repository.dart';
import 'package:web3dart/web3dart.dart';
import 'package:scavium_wallet/features/blockchain/domain/scavium_rpc_status.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});

final scaviumRpcServiceProvider = Provider<ScaviumRpcService>((ref) {
  return ScaviumRpcService(
    client: ref.read(httpClientProvider),
    walletRepository: ref.read(walletRepositoryProvider),
  );
});

class ScaviumRpcService {
  final http.Client client;
  final WalletRepository walletRepository;

  int _activeRpcIndex = 0;

  ScaviumRpcService({required this.client, required this.walletRepository});

  static const String _erc20Abi = '''
[
  {"constant":true,"inputs":[{"name":"owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"type":"function","stateMutability":"view"},
  {"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"type":"function","stateMutability":"view"},
  {"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"type":"function","stateMutability":"view"},
  {"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"type":"function","stateMutability":"view"},
  {"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"type":"function","stateMutability":"view"},
  {"constant":false,"inputs":[{"name":"to","type":"address"},{"name":"value","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"type":"function","stateMutability":"nonpayable"}
]
''';

  List<String> _validatedRpcUrls() {
    RpcUrlValidator.validateAll(AppConfig.current.rpcUrls);
    return AppConfig.current.rpcUrls;
  }

  String get activeRpcUrl {
    final rpcUrls = _validatedRpcUrls();
    if (_activeRpcIndex < 0 || _activeRpcIndex >= rpcUrls.length) {
      _activeRpcIndex = 0;
    }
    return rpcUrls[_activeRpcIndex];
  }

  void _setActiveRpcIndex(int index) {
    final rpcUrls = _validatedRpcUrls();
    if (index < 0 || index >= rpcUrls.length) return;
    _activeRpcIndex = index;
  }

  void _promoteRpcIndex(int index) {
    if (_activeRpcIndex == index) return;
    _setActiveRpcIndex(index);
  }

  void _advanceRpcIndex() {
    final rpcUrls = _validatedRpcUrls();
    if (rpcUrls.isEmpty) return;
    _activeRpcIndex = (_activeRpcIndex + 1) % rpcUrls.length;
  }

  List<int> _rpcAttemptOrder() {
    final rpcUrls = _validatedRpcUrls();
    if (rpcUrls.isEmpty) return const [];

    final order = <int>[];
    for (var offset = 0; offset < rpcUrls.length; offset++) {
      order.add((_activeRpcIndex + offset) % rpcUrls.length);
    }
    return order;
  }

  bool _isRetryableRpcError(Object error) {
    final raw = error.toString().toLowerCase();

    if (error is SocketException) return true;
    if (error is HandshakeException) return true;
    if (error is HttpException) return true;

    if (raw.contains('socketexception')) return true;
    if (raw.contains('handshakeexception')) return true;
    if (raw.contains('failed host lookup')) return true;
    if (raw.contains('connection closed before full header was received')) {
      return true;
    }
    if (raw.contains('connection refused')) return true;
    if (raw.contains('connection reset by peer')) return true;
    if (raw.contains('network is unreachable')) return true;
    if (raw.contains('software caused connection abort')) return true;
    if (raw.contains('timed out')) return true;
    if (raw.contains('timeout')) return true;
    if (raw.contains('http exception')) return true;
    if (raw.contains('clientexception')) return true;
    if (raw.contains('tls')) return true;
    if (raw.contains('handshake')) return true;
    if (raw.contains('502 bad gateway')) return true;
    if (raw.contains('503 service unavailable')) return true;
    if (raw.contains('504 gateway timeout')) return true;

    return false;
  }

  Web3Client _web3ForUrl(String rpcUrl) {
    return Web3Client(rpcUrl, client);
  }

  Future<T> _executeReadWithFallback<T>(
    Future<T> Function(Web3Client web3) action,
  ) async {
    final order = _rpcAttemptOrder();
    Object? lastError;

    for (final index in order) {
      final rpcUrl = _validatedRpcUrls()[index];
      final web3 = _web3ForUrl(rpcUrl);

      try {
        final result = await action(web3);
        _promoteRpcIndex(index);
        return result;
      } catch (error) {
        lastError = error;

        if (!_isRetryableRpcError(error)) {
          rethrow;
        }
      } finally {
        web3.dispose();
      }
    }

    if (lastError != null) {
      throw lastError;
    }

    throw StateError('No RPC endpoints available');
  }

  Future<T> _executeWriteOnActiveRpc<T>(
    Future<T> Function(Web3Client web3) action,
  ) async {
    final rpcUrl = activeRpcUrl;
    final web3 = _web3ForUrl(rpcUrl);

    try {
      final result = await action(web3);
      return result;
    } catch (error) {
      if (_isRetryableRpcError(error)) {
        _advanceRpcIndex();
      }
      rethrow;
    } finally {
      web3.dispose();
    }
  }

  Future<NetworkInfo> getNetworkInfo() async {
    return _executeReadWithFallback((web3) async {
      final chainId = await web3.getChainId();
      final gasPrice = await web3.getGasPrice();
      final block = await web3.getBlockNumber();

      return NetworkInfo(
        chainId: chainId.toInt(),
        gasPriceWei: gasPrice.getInWei,
        latestBlock: block,
      );
    });
  }

  Future<EthereumAddress> getCurrentAddress() async {
    final profile = await walletRepository.loadWalletProfile();
    if (profile == null) {
      throw Exception('No wallet profile loaded');
    }
    return EthereumAddress.fromHex(profile.account.address);
  }

  Future<Credentials> getCredentials() async {
    final mnemonic = await walletRepository.readMnemonic();
    if (mnemonic != null && mnemonic.isNotEmpty) {
      return walletRepository.credentialsFromMnemonic(mnemonic);
    }

    final privateKey = await walletRepository.readPrivateKey();
    if (privateKey != null && privateKey.isNotEmpty) {
      return EthPrivateKey.fromHex(privateKey);
    }

    throw Exception('No credentials available');
  }

  Future<EtherAmount> getNativeBalance() async {
    final address = await getCurrentAddress();

    return _executeReadWithFallback((web3) async {
      return web3.getBalance(address);
    });
  }

  Future<BigInt> estimateGasForNativeTransfer({
    required EthereumAddress to,
    required EtherAmount value,
  }) async {
    final from = await getCurrentAddress();

    return _executeReadWithFallback((web3) async {
      return web3.estimateGas(sender: from, to: to, value: value);
    });
  }

  Future<TransactionSendResult> sendNativeTransaction({
    required String toAddress,
    required EtherAmount amount,
  }) async {
    final credentials = await getCredentials();
    final to = EthereumAddress.fromHex(toAddress);

    return _executeWriteOnActiveRpc((web3) async {
      final txHash = await web3.sendTransaction(
        credentials,
        Transaction(to: to, value: amount),
        chainId: AppConfig.current.chainId,
        fetchChainIdFromNetworkId: false,
      );

      final receipt = await waitForReceipt(txHash);

      return TransactionSendResult(txHash: txHash, confirmed: receipt == true);
    });
  }

  DeployedContract _erc20Contract(String contractAddress) {
    final contract = DeployedContract(
      ContractAbi.fromJson(_erc20Abi, 'ERC20'),
      EthereumAddress.fromHex(contractAddress),
    );
    return contract;
  }

  Future<TokenInfo> loadTokenMetadata(String contractAddress) async {
    final contract = _erc20Contract(contractAddress);

    return _executeReadWithFallback((web3) async {
      final nameFn = contract.function('name');
      final symbolFn = contract.function('symbol');
      final decimalsFn = contract.function('decimals');

      String name = '';
      String symbol = '';
      int decimals = 18;

      try {
        final nameRes = await web3.call(
          contract: contract,
          function: nameFn,
          params: const [],
        );
        name = (nameRes.first as String).trim();
      } catch (_) {
        name = 'Unknown Token';
      }

      try {
        final symbolRes = await web3.call(
          contract: contract,
          function: symbolFn,
          params: const [],
        );
        symbol = (symbolRes.first as String).trim();
      } catch (_) {
        symbol = 'TOKEN';
      }

      try {
        final decimalsRes = await web3.call(
          contract: contract,
          function: decimalsFn,
          params: const [],
        );
        final raw = decimalsRes.first;
        if (raw is int) {
          decimals = raw;
        } else if (raw is BigInt) {
          decimals = raw.toInt();
        }
      } catch (_) {
        decimals = 18;
      }

      return TokenInfo(
        contractAddress: EthereumAddress.fromHex(contractAddress).hexEip55,
        name: name.isEmpty ? 'Unknown Token' : name,
        symbol: symbol.isEmpty ? 'TOKEN' : symbol,
        decimals: decimals,
      );
    });
  }

  Future<BigInt> getErc20Balance(String contractAddress) async {
    final owner = await getCurrentAddress();
    final contract = _erc20Contract(contractAddress);
    final fn = contract.function('balanceOf');

    return _executeReadWithFallback((web3) async {
      final result = await web3.call(
        contract: contract,
        function: fn,
        params: [owner],
      );

      return result.first as BigInt;
    });
  }

  Future<BigInt> estimateGasForErc20Transfer({
    required String contractAddress,
    required String toAddress,
    required BigInt amountRaw,
  }) async {
    final sender = await getCurrentAddress();
    final contract = _erc20Contract(contractAddress);
    final fn = contract.function('transfer');
    final data = fn.encodeCall([EthereumAddress.fromHex(toAddress), amountRaw]);

    return _executeReadWithFallback((web3) async {
      return web3.estimateGas(
        sender: sender,
        to: EthereumAddress.fromHex(contractAddress),
        data: data,
      );
    });
  }

  Future<TransactionSendResult> sendErc20Transaction({
    required String contractAddress,
    required String toAddress,
    required BigInt amountRaw,
  }) async {
    final credentials = await getCredentials();
    final contract = _erc20Contract(contractAddress);
    final fn = contract.function('transfer');

    return _executeWriteOnActiveRpc((web3) async {
      final txHash = await web3.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: fn,
          parameters: [EthereumAddress.fromHex(toAddress), amountRaw],
        ),
        chainId: AppConfig.current.chainId,
        fetchChainIdFromNetworkId: false,
      );

      final receipt = await waitForReceipt(txHash);

      return TransactionSendResult(txHash: txHash, confirmed: receipt == true);
    });
  }

  Future<TransactionReceipt?> getReceipt(String txHash) async {
    return _executeReadWithFallback((web3) async {
      return web3.getTransactionReceipt(txHash);
    });
  }

  Future<bool?> waitForReceipt(
    String txHash, {
    int maxAttempts = 20,
    Duration delay = const Duration(seconds: 3),
  }) async {
    for (var i = 0; i < maxAttempts; i++) {
      try {
        final receipt = await getReceipt(txHash);
        if (receipt != null) {
          return receipt.status ?? true;
        }
      } catch (_) {
        // dejamos que el polling continúe con el RPC activo/fallback
      }

      await Future<void>.delayed(delay);
    }

    return null;
  }

  String explorerAddressUrl(String address) {
    return '${AppConfig.current.addressExplorerPath}/$address';
  }

  String explorerTxUrl(String txHash) {
    return '${AppConfig.current.txExplorerPath}/$txHash';
  }

  Future<BigInt> getCurrentGasPriceWei() async {
    return _executeReadWithFallback((web3) async {
      final gasPrice = await web3.getGasPrice();
      return gasPrice.getInWei;
    });
  }

  Future<String> normalizeRpcError(Object error) async {
    final raw = error.toString();

    if (raw.contains('insufficient funds')) {
      return 'Fondos insuficientes para cubrir el monto y la comisión.';
    }

    if (raw.contains('nonce')) {
      return 'Problema de nonce al enviar la transacción.';
    }

    if (raw.contains('timeout')) {
      return 'Tiempo de espera agotado al comunicarse con el nodo RPC.';
    }

    if (raw.contains('SocketException')) {
      return 'No se pudo conectar al nodo RPC.';
    }

    if (raw.contains('HandshakeException')) {
      return 'No se pudo establecer una conexión segura con el nodo RPC.';
    }

    if (raw.contains('Invalid argument')) {
      return 'Argumentos inválidos al construir la transacción.';
    }

    return raw;
  }

  ScaviumRpcStatus getRpcStatus() {
    final rpcUrls = _validatedRpcUrls();

    if (_activeRpcIndex < 0 || _activeRpcIndex >= rpcUrls.length) {
      _activeRpcIndex = 0;
    }

    return ScaviumRpcStatus(
      activeIndex: _activeRpcIndex,
      activeRpcUrl: rpcUrls[_activeRpcIndex],
      rpcUrls: List<String>.unmodifiable(rpcUrls),
    );
  }

  Future<void> setActiveRpcByIndex(int index) async {
    final rpcUrls = _validatedRpcUrls();

    if (index < 0 || index >= rpcUrls.length) {
      throw ArgumentError('Índice RPC inválido: $index');
    }

    final web3 = _web3ForUrl(rpcUrls[index]);

    try {
      await web3.getChainId();
      _setActiveRpcIndex(index);
    } finally {
      web3.dispose();
    }
  }

  Future<bool> pingActiveRpc() async {
    final web3 = _web3ForUrl(activeRpcUrl);

    try {
      await web3.getChainId();
      return true;
    } catch (_) {
      return false;
    } finally {
      web3.dispose();
    }
  }

  Future<bool> pingRpcByIndex(int index) async {
    final rpcUrls = _validatedRpcUrls();

    if (index < 0 || index >= rpcUrls.length) {
      return false;
    }

    final web3 = _web3ForUrl(rpcUrls[index]);

    try {
      await web3.getChainId();
      return true;
    } catch (_) {
      return false;
    } finally {
      web3.dispose();
    }
  }
}
