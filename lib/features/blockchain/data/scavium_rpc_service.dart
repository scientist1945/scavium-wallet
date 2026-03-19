import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:scavium_wallet/core/config/app_config.dart';
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
      final chainId = AppConfig.current.chainId;

      final txHash = await web3.sendTransaction(
        credentials,
        Transaction(to: to, value: amount),
        chainId: chainId,
        fetchChainIdFromNetworkId: false,
      );

      final confirmed = await waitForReceipt(txHash);

      return TransactionSendResult(txHash: txHash, confirmed: confirmed);
    } finally {
      web3.dispose();
    }
  }

  Future<bool> waitForReceipt(
    String txHash, {
    int maxAttempts = 20,
    Duration delay = const Duration(seconds: 3),
  }) async {
    final web3 = _web3();
    try {
      for (var i = 0; i < maxAttempts; i++) {
        final receipt = await web3.getTransactionReceipt(txHash);
        if (receipt != null) {
          return true;
        }
        await Future<void>.delayed(delay);
      }
      return false;
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
