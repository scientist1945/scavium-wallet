import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/features/assets/domain/token_info.dart';
import 'package:scavium_wallet/features/blockchain/domain/network_info.dart';
import 'package:scavium_wallet/features/blockchain/domain/transaction_send_result.dart';
import 'package:scavium_wallet/features/wallet/data/wallet_repository_impl.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_repository.dart';
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
  );
});

class ScaviumRpcService {
  final http.Client client;
  final WalletRepository walletRepository;

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

  Web3Client _web3() {
    return Web3Client(AppConfig.current.rpcUrl, client);
  }

  Future<NetworkInfo> getNetworkInfo() async {
    final web3 = _web3();
    try {
      final chainId = await web3.getChainId();
      final gasPrice = await web3.getGasPrice();
      final block = await web3.getBlockNumber();

      return NetworkInfo(
        chainId: chainId.toInt(),
        gasPriceWei: gasPrice.getInWei,
        latestBlock: block,
      );
    } finally {
      web3.dispose();
    }
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
    final web3 = _web3();
    try {
      final address = await getCurrentAddress();
      return web3.getBalance(address);
    } finally {
      web3.dispose();
    }
  }

  Future<BigInt> estimateGasForNativeTransfer({
    required EthereumAddress to,
    required EtherAmount value,
  }) async {
    final web3 = _web3();
    try {
      final from = await getCurrentAddress();
      return web3.estimateGas(sender: from, to: to, value: value);
    } finally {
      web3.dispose();
    }
  }

  Future<TransactionSendResult> sendNativeTransaction({
    required String toAddress,
    required EtherAmount amount,
  }) async {
    final web3 = _web3();
    try {
      final credentials = await getCredentials();
      final to = EthereumAddress.fromHex(toAddress);
      final txHash = await web3.sendTransaction(
        credentials,
        Transaction(to: to, value: amount),
        chainId: AppConfig.current.chainId,
        fetchChainIdFromNetworkId: false,
      );

      final receipt = await waitForReceipt(txHash);

      return TransactionSendResult(txHash: txHash, confirmed: receipt == true);
    } finally {
      web3.dispose();
    }
  }

  DeployedContract _erc20Contract(String contractAddress) {
    final contract = DeployedContract(
      ContractAbi.fromJson(_erc20Abi, 'ERC20'),
      EthereumAddress.fromHex(contractAddress),
    );
    return contract;
  }

  Future<TokenInfo> loadTokenMetadata(String contractAddress) async {
    final web3 = _web3();
    try {
      final contract = _erc20Contract(contractAddress);

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
    } finally {
      web3.dispose();
    }
  }

  Future<BigInt> getErc20Balance(String contractAddress) async {
    final web3 = _web3();
    try {
      final owner = await getCurrentAddress();
      final contract = _erc20Contract(contractAddress);
      final fn = contract.function('balanceOf');

      final result = await web3.call(
        contract: contract,
        function: fn,
        params: [owner],
      );

      return result.first as BigInt;
    } finally {
      web3.dispose();
    }
  }

  Future<BigInt> estimateGasForErc20Transfer({
    required String contractAddress,
    required String toAddress,
    required BigInt amountRaw,
  }) async {
    final web3 = _web3();
    try {
      final sender = await getCurrentAddress();
      final contract = _erc20Contract(contractAddress);
      final fn = contract.function('transfer');
      final data = fn.encodeCall([
        EthereumAddress.fromHex(toAddress),
        amountRaw,
      ]);

      return web3.estimateGas(
        sender: sender,
        to: EthereumAddress.fromHex(contractAddress),
        data: data,
      );
    } finally {
      web3.dispose();
    }
  }

  Future<TransactionSendResult> sendErc20Transaction({
    required String contractAddress,
    required String toAddress,
    required BigInt amountRaw,
  }) async {
    final web3 = _web3();
    try {
      final credentials = await getCredentials();
      final contract = _erc20Contract(contractAddress);
      final fn = contract.function('transfer');

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
    } finally {
      web3.dispose();
    }
  }

  Future<TransactionReceipt?> getReceipt(String txHash) async {
    final web3 = _web3();
    try {
      return web3.getTransactionReceipt(txHash);
    } finally {
      web3.dispose();
    }
  }

  Future<bool?> waitForReceipt(
    String txHash, {
    int maxAttempts = 20,
    Duration delay = const Duration(seconds: 3),
  }) async {
    final web3 = _web3();
    try {
      for (var i = 0; i < maxAttempts; i++) {
        final receipt = await web3.getTransactionReceipt(txHash);
        if (receipt != null) {
          return receipt.status ?? true;
        }
        await Future<void>.delayed(delay);
      }
      return null;
    } finally {
      web3.dispose();
    }
  }

  String explorerAddressUrl(String address) {
    return '${AppConfig.current.addressExplorerPath}/$address';
  }

  String explorerTxUrl(String txHash) {
    return '${AppConfig.current.txExplorerPath}/$txHash';
  }
}
