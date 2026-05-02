import 'package:scavium_wallet/features/assets/domain/asset_item.dart';
import 'package:scavium_wallet/features/assets/domain/asset_kind.dart';

class PortfolioSummary {
  final int totalAssets;
  final int nativeAssetCount;
  final int erc20AssetCount;
  final int nonZeroAssetCount;

  const PortfolioSummary({
    required this.totalAssets,
    required this.nativeAssetCount,
    required this.erc20AssetCount,
    required this.nonZeroAssetCount,
  });

  bool get hasAssets => totalAssets > 0;
  bool get hasNonZeroAssets => nonZeroAssetCount > 0;

  factory PortfolioSummary.fromAssets(List<AssetItem> assets) {
    var nativeAssetCount = 0;
    var erc20AssetCount = 0;
    var nonZeroAssetCount = 0;

    for (final asset in assets) {
      switch (asset.kind) {
        case AssetKind.native:
          nativeAssetCount++;
        case AssetKind.erc20:
          erc20AssetCount++;
      }

      if (asset.rawBalance > BigInt.zero) {
        nonZeroAssetCount++;
      }
    }

    return PortfolioSummary(
      totalAssets: assets.length,
      nativeAssetCount: nativeAssetCount,
      erc20AssetCount: erc20AssetCount,
      nonZeroAssetCount: nonZeroAssetCount,
    );
  }
}
