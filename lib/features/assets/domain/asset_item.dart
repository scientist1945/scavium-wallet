import 'package:scavium_wallet/features/assets/domain/asset_kind.dart';

class AssetItem {
  final AssetKind kind;
  final String title;
  final String symbol;
  final String? contractAddress;
  final int decimals;
  final BigInt rawBalance;
  final String displayBalance;

  const AssetItem({
    required this.kind,
    required this.title,
    required this.symbol,
    required this.contractAddress,
    required this.decimals,
    required this.rawBalance,
    required this.displayBalance,
  });
}
