import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/assets/domain/asset_item.dart';
import 'package:scavium_wallet/features/assets/domain/asset_kind.dart';
import 'package:scavium_wallet/features/assets/domain/portfolio_summary.dart';

void main() {
  group('PortfolioSummary', () {
    test('summarizes empty assets safely', () {
      final summary = PortfolioSummary.fromAssets(const <AssetItem>[]);

      expect(summary.totalAssets, 0);
      expect(summary.nativeAssetCount, 0);
      expect(summary.erc20AssetCount, 0);
      expect(summary.nonZeroAssetCount, 0);
      expect(summary.hasAssets, isFalse);
      expect(summary.hasNonZeroAssets, isFalse);
    });

    test('summarizes visible native and ERC-20 assets deterministically', () {
      final summary = PortfolioSummary.fromAssets([
        AssetItem(
          kind: AssetKind.native,
          title: 'SCAVIUM',
          symbol: 'SCV',
          contractAddress: null,
          decimals: 18,
          rawBalance: BigInt.from(10),
          displayBalance: '0.000000',
        ),
        AssetItem(
          kind: AssetKind.erc20,
          title: 'Test Token',
          symbol: 'TEST',
          contractAddress: '0x1111111111111111111111111111111111111111',
          decimals: 18,
          rawBalance: BigInt.zero,
          displayBalance: '0',
        ),
        AssetItem(
          kind: AssetKind.erc20,
          title: 'Second Token',
          symbol: 'SECOND',
          contractAddress: '0x2222222222222222222222222222222222222222',
          decimals: 6,
          rawBalance: BigInt.from(25),
          displayBalance: '0.000025',
        ),
      ]);

      expect(summary.totalAssets, 3);
      expect(summary.nativeAssetCount, 1);
      expect(summary.erc20AssetCount, 2);
      expect(summary.nonZeroAssetCount, 2);
      expect(summary.hasAssets, isTrue);
      expect(summary.hasNonZeroAssets, isTrue);
    });
  });
}
