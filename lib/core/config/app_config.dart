import 'package:scavium_wallet/core/config/app_flavor.dart';

class AppConfig {
  final AppFlavor flavor;
  final String appName;
  final String rpcUrl;
  final String explorerBaseUrl;
  final int chainId;
  final String nativeSymbol;
  final int nativeDecimals;

  const AppConfig({
    required this.flavor,
    required this.appName,
    required this.rpcUrl,
    required this.explorerBaseUrl,
    required this.chainId,
    required this.nativeSymbol,
    required this.nativeDecimals,
  });

  String get addressExplorerPath => '$explorerBaseUrl/address';
  String get txExplorerPath => '$explorerBaseUrl/tx';

  static const current = AppConfig(
    flavor: AppFlavor.dev,
    appName: 'SCAVIUM Wallet',
    rpcUrl: 'https://rpc.testnet.scavium.network:18545',
    explorerBaseUrl: 'https://explorer.testnet.scavium.network',
    chainId: 13371,
    nativeSymbol: 'SCAV',
    nativeDecimals: 18,
  );
}
