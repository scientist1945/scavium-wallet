import 'package:scavium_wallet/core/config/app_flavor.dart';

class AppConfig {
  final AppFlavor flavor;
  final String appName;
  final String rpcUrl;
  final String explorerBaseUrl;
  final int chainId;

  const AppConfig({
    required this.flavor,
    required this.appName,
    required this.rpcUrl,
    required this.explorerBaseUrl,
    required this.chainId,
  });

  static const current = AppConfig(
    flavor: AppFlavor.dev,
    appName: 'SCAVIUM Wallet',
    rpcUrl: 'https://rpc.testnet.scavium.network',
    explorerBaseUrl: 'https://explorer.testnet.scavium.network',
    chainId: 13371,
  );
}
