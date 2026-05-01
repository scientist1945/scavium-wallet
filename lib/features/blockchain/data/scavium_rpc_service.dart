import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/services/local_storage_service.dart';
import 'package:scavium_wallet/core/utils/rpc_url_validator.dart';
import 'package:scavium_wallet/features/assets/domain/token_info.dart';
import 'package:scavium_wallet/features/blockchain/domain/network_info.dart';
import 'package:scavium_wallet/features/blockchain/domain/scavium_rpc_status.dart';
import 'package:scavium_wallet/features/blockchain/domain/transaction_send_result.dart';
import 'package:scavium_wallet/features/signing/domain/signing_mode.dart';
import 'package:scavium_wallet/features/signing/domain/signing_result.dart';
import 'package:scavium_wallet/features/wallet/data/wallet_repository_impl.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_repository.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});

final scaviumRpcServiceProvider = Provider<ScaviumRpcService>((ref) {
  return ScaviumRpcService(
    client: ref.read(httpClientProvider),
    walletRepository: ref.read(walletRepositoryProvider),
    localStorage: LocalStorageService(),
  );
});

class ScaviumRpcService {
  final http.Client client;
  final WalletRepository walletRepository;
  final LocalStorageService localStorage;

  int _activeRpcIndex = 0;
  bool _hydrated = false;
  final Map<String, int> _cooldownUntilEpochMsByUrl = {};

  DateTime? _lastSwitchAt;
  String? _lastSwitchReason;
  String? _lastFailedRpcUrl;

  static const Duration _rpcCooldown = Duration(seconds: 60);

  ScaviumRpcService({
    required this.client,
    required this.walletRepository,
    required this.localStorage,
  });

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

  Future<void> _ensureHydrated() async {
    if (_hydrated) return;
    await _hydrateState();
    _hydrated = true;
  }

  Future<void> _hydrateState() async {
    final rpcUrls = _validatedRpcUrls();

    final savedIndex = await localStorage.getInt(StorageKeys.rpcActiveIndex);
    if (savedIndex != null && savedIndex >= 0 && savedIndex < rpcUrls.length) {
      _activeRpcIndex = savedIndex;
    } else {
      _activeRpcIndex = 0;
    }

    final rawCooldown = await localStorage.getString(
      StorageKeys.rpcCooldownUntilByUrl,
    );

    if (rawCooldown != null && rawCooldown.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawCooldown);

        if (decoded is Map<String, dynamic>) {
          for (final entry in decoded.entries) {
            final value = entry.value;
            if (value is int) {
              _cooldownUntilEpochMsByUrl[entry.key] = value;
            }
          }
        }
      } catch (_) {
        _cooldownUntilEpochMsByUrl.clear();
      }
    }

    _pruneExpiredCooldowns();

    if (_activeRpcIndex < 0 || _activeRpcIndex >= rpcUrls.length) {
      _activeRpcIndex = 0;
    }
  }

  Future<void> _persistState() async {
    await localStorage.setInt(StorageKeys.rpcActiveIndex, _activeRpcIndex);

    _pruneExpiredCooldowns();

    if (_cooldownUntilEpochMsByUrl.isEmpty) {
      await localStorage.remove(StorageKeys.rpcCooldownUntilByUrl);
      return;
    }

    await localStorage.setString(
      StorageKeys.rpcCooldownUntilByUrl,
      jsonEncode(_cooldownUntilEpochMsByUrl),
    );
  }

  void _pruneExpiredCooldowns() {
    final now = DateTime.now().millisecondsSinceEpoch;
    _cooldownUntilEpochMsByUrl.removeWhere((_, until) => until <= now);
  }

  DateTime? _cooldownUntilForUrl(String rpcUrl) {
    _pruneExpiredCooldowns();
    final epoch = _cooldownUntilEpochMsByUrl[rpcUrl];
    if (epoch == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(epoch);
  }

  bool _isRpcCoolingDown(String rpcUrl) {
    final until = _cooldownUntilForUrl(rpcUrl);
    if (until == null) return false;
    return until.isAfter(DateTime.now());
  }

  void _markRpcFailedByIndex(int index) {
    final rpcUrls = _validatedRpcUrls();
    if (index < 0 || index >= rpcUrls.length) return;

    final until = DateTime.now().add(_rpcCooldown).millisecondsSinceEpoch;
    _cooldownUntilEpochMsByUrl[rpcUrls[index]] = until;
  }

  void _clearRpcCooldownByIndex(int index) {
    final rpcUrls = _validatedRpcUrls();
    if (index < 0 || index >= rpcUrls.length) return;

    _cooldownUntilEpochMsByUrl.remove(rpcUrls[index]);
  }

  void _recordRpcSwitch({required String reason, String? failedRpcUrl}) {
    _lastSwitchAt = DateTime.now();
    _lastSwitchReason = reason;
    _lastFailedRpcUrl = failedRpcUrl;
  }

  String _activeRpcUrlSync() {
    final rpcUrls = _validatedRpcUrls();

    if (_activeRpcIndex < 0 || _activeRpcIndex >= rpcUrls.length) {
      _activeRpcIndex = 0;
    }

    return rpcUrls[_activeRpcIndex];
  }

  List<int> _rpcAttemptOrderSync({bool skipCoolingDown = true}) {
    final rpcUrls = _validatedRpcUrls();
    if (rpcUrls.isEmpty) return const [];

    final order = <int>[];
    for (var offset = 0; offset < rpcUrls.length; offset++) {
      order.add((_activeRpcIndex + offset) % rpcUrls.length);
    }

    if (!skipCoolingDown) {
      return order;
    }

    final preferred =
        order.where((index) {
          final rpcUrl = rpcUrls[index];
          return !_isRpcCoolingDown(rpcUrl);
        }).toList();

    if (preferred.isNotEmpty) {
      return preferred;
    }

    return order;
  }

  Future<void> _promoteRpcIndex(
    int index, {
    String? reason,
    String? failedRpcUrl,
  }) async {
    final rpcUrls = _validatedRpcUrls();
    if (index < 0 || index >= rpcUrls.length) return;

    final previousIndex = _activeRpcIndex;
    _activeRpcIndex = index;
    _clearRpcCooldownByIndex(index);

    if (reason != null && previousIndex != index) {
      _recordRpcSwitch(reason: reason, failedRpcUrl: failedRpcUrl);
    }

    await _persistState();
  }

  Future<void> _advanceRpcIndexAfterFailure(int failedIndex) async {
    final rpcUrls = _validatedRpcUrls();
    if (rpcUrls.isEmpty) return;

    _markRpcFailedByIndex(failedIndex);

    final previousIndex = _activeRpcIndex;
    final failedRpcUrl = rpcUrls[failedIndex];

    final order = _rpcAttemptOrderSync(skipCoolingDown: true);
    if (order.isNotEmpty) {
      _activeRpcIndex = order.first;
    } else {
      _activeRpcIndex = (_activeRpcIndex + 1) % rpcUrls.length;
    }

    if (previousIndex != _activeRpcIndex) {
      _recordRpcSwitch(reason: 'failover', failedRpcUrl: failedRpcUrl);
    }

    await _persistState();
  }

  bool _isRetryableRpcError(Object error) {
    final raw = error.toString().toLowerCase();

    if (error is SocketException) return true;
    if (error is HandshakeException) return true;
    if (error is HttpException) return true;
    if (error is FormatException) return true;

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
    if (raw.contains('formatexception')) return true;
    if (raw.contains('unexpected character')) return true;
    if (raw.contains('<html>')) return true;
    if (raw.contains('<!doctype html')) return true;

    return false;
  }

  Web3Client _web3ForUrl(String rpcUrl) {
    return Web3Client(rpcUrl, client);
  }

  Future<T> _executeReadWithFallback<T>(
    Future<T> Function(Web3Client web3) action,
  ) async {
    await _ensureHydrated();

    final initialIndex = _activeRpcIndex;
    final initialRpcUrl = _validatedRpcUrls()[initialIndex];

    final order = _rpcAttemptOrderSync(skipCoolingDown: true);
    Object? lastError;

    for (final index in order) {
      final rpcUrl = _validatedRpcUrls()[index];
      final web3 = _web3ForUrl(rpcUrl);

      try {
        final result = await action(web3);

        if (index != initialIndex) {
          await _promoteRpcIndex(
            index,
            reason: 'failover',
            failedRpcUrl: initialRpcUrl,
          );
        } else {
          await _promoteRpcIndex(index);
        }

        return result;
      } catch (error) {
        lastError = error;

        if (!_isRetryableRpcError(error)) {
          rethrow;
        }

        _markRpcFailedByIndex(index);
        await _persistState();
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
    await _ensureHydrated();

    final failedIndex = _activeRpcIndex;
    final rpcUrl = _activeRpcUrlSync();
    final web3 = _web3ForUrl(rpcUrl);

    try {
      final result = await action(web3);
      _clearRpcCooldownByIndex(failedIndex);
      await _persistState();
      return result;
    } catch (error) {
      if (_isRetryableRpcError(error)) {
        await _advanceRpcIndexAfterFailure(failedIndex);
      }
      rethrow;
    } finally {
      web3.dispose();
    }
  }

  Future<ScaviumRpcStatus> getRpcStatus() async {
    await _ensureHydrated();

    final rpcUrls = _validatedRpcUrls();
    final cooldowns = <String, DateTime?>{
      for (final url in rpcUrls) url: _cooldownUntilForUrl(url),
    };

    return ScaviumRpcStatus(
      activeIndex: _activeRpcIndex,
      activeRpcUrl: _activeRpcUrlSync(),
      rpcUrls: List<String>.unmodifiable(rpcUrls),
      cooldownUntilByRpcUrl: Map<String, DateTime?>.unmodifiable(cooldowns),
      lastSwitchAt: _lastSwitchAt,
      lastSwitchReason: _lastSwitchReason,
      lastFailedRpcUrl: _lastFailedRpcUrl,
    );
  }

  Future<void> setActiveRpcByIndex(int index) async {
    await _ensureHydrated();

    final rpcUrls = _validatedRpcUrls();

    if (index < 0 || index >= rpcUrls.length) {
      throw ArgumentError('Índice RPC inválido: $index');
    }

    final previousIndex = _activeRpcIndex;
    final web3 = _web3ForUrl(rpcUrls[index]);

    try {
      await web3.getChainId();
      _activeRpcIndex = index;
      _clearRpcCooldownByIndex(index);

      if (previousIndex != index) {
        _recordRpcSwitch(reason: 'manual');
      }

      await _persistState();
    } finally {
      web3.dispose();
    }
  }

  Future<bool> pingActiveRpc() async {
    await _ensureHydrated();

    final web3 = _web3ForUrl(_activeRpcUrlSync());

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
    await _ensureHydrated();

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
    return walletRepository.credentialsForActiveAccount();
  }

  Future<SigningResult> signPersonalMessage(String message) {
    return _signMessage(message: message, mode: SigningMode.personalMessage);
  }

  Future<SigningResult> signChallengeMessage(String message) {
    return _signMessage(message: message, mode: SigningMode.challengeMessage);
  }

  Future<SigningResult> _signMessage({
    required String message,
    required SigningMode mode,
  }) async {
    final normalizedMessage = message.trim();
    if (normalizedMessage.isEmpty) {
      throw Exception('Signing message cannot be empty');
    }

    final profile = await walletRepository.loadWalletProfile();
    if (profile == null) {
      throw Exception('No wallet profile loaded');
    }

    final activeAccount = profile.activeAccount;
    final credentials = await walletRepository.credentialsForActiveAccount();
    final signatureBytes = await credentials.signPersonalMessageToUint8List(
      Uint8List.fromList(utf8.encode(normalizedMessage)),
    );

    return SigningResult(
      mode: mode,
      accountAddress: activeAccount.address,
      message: normalizedMessage,
      signature: bytesToHex(signatureBytes, include0x: true),
      signedAt: DateTime.now().toUtc(),
    );
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
    return DeployedContract(
      ContractAbi.fromJson(_erc20Abi, 'ERC20'),
      EthereumAddress.fromHex(contractAddress),
    );
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
      } catch (_) {}

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
}
