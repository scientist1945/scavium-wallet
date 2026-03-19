import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/features/assets/application/token_registry_controller.dart';
import 'package:scavium_wallet/features/assets/data/token_registry_repository_impl.dart';
import 'package:scavium_wallet/features/assets/domain/asset_item.dart';
import 'package:scavium_wallet/features/assets/domain/asset_kind.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:web3dart/web3dart.dart';

final assetsControllerProvider =
    AsyncNotifierProvider<AssetsController, List<AssetItem>>(
      AssetsController.new,
    );

class AssetsController extends AsyncNotifier<List<AssetItem>> {
  @override
  Future<List<AssetItem>> build() async {
    final rpc = ref.read(scaviumRpcServiceProvider);
    final tokens = ref.watch(tokenRegistryControllerProvider).valueOrNull ?? [];

    final native = await rpc.getNativeBalance();

    final items = <AssetItem>[
      AssetItem(
        kind: AssetKind.native,
        title: 'SCAVIUM',
        symbol: AppConfig.current.nativeSymbol,
        contractAddress: null,
        decimals: AppConfig.current.nativeDecimals,
        rawBalance: native.getInWei,
        displayBalance: native
            .getValueInUnit(EtherUnit.ether)
            .toStringAsFixed(6),
      ),
    ];

    for (final token in tokens) {
      final rawBalance = await rpc.getErc20Balance(token.contractAddress);
      items.add(
        AssetItem(
          kind: AssetKind.erc20,
          title: token.name,
          symbol: token.symbol,
          contractAddress: token.contractAddress,
          decimals: token.decimals,
          rawBalance: rawBalance,
          displayBalance: _formatUnits(rawBalance, token.decimals),
        ),
      );
    }

    return items;
  }

  Future<void> refreshAssets() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      ref.invalidate(tokenRegistryControllerProvider);
      final rpc = ref.read(scaviumRpcServiceProvider);
      final tokens =
          await ref.read(tokenRegistryRepositoryProvider).getTokens();

      final native = await rpc.getNativeBalance();

      final items = <AssetItem>[
        AssetItem(
          kind: AssetKind.native,
          title: 'SCAVIUM',
          symbol: AppConfig.current.nativeSymbol,
          contractAddress: null,
          decimals: AppConfig.current.nativeDecimals,
          rawBalance: native.getInWei,
          displayBalance: native
              .getValueInUnit(EtherUnit.ether)
              .toStringAsFixed(6),
        ),
      ];

      for (final token in tokens) {
        final rawBalance = await rpc.getErc20Balance(token.contractAddress);
        items.add(
          AssetItem(
            kind: AssetKind.erc20,
            title: token.name,
            symbol: token.symbol,
            contractAddress: token.contractAddress,
            decimals: token.decimals,
            rawBalance: rawBalance,
            displayBalance: _formatUnits(rawBalance, token.decimals),
          ),
        );
      }

      return items;
    });
  }

  String _formatUnits(BigInt value, int decimals) {
    if (decimals == 0) return value.toString();
    final divisor = BigInt.from(10).pow(decimals);
    final whole = value ~/ divisor;
    final fraction = (value % divisor).toString().padLeft(decimals, '0');
    final trimmedFraction = fraction.replaceFirst(RegExp(r'0+$'), '');
    if (trimmedFraction.isEmpty) return whole.toString();
    return '$whole.${trimmedFraction.length > 6 ? trimmedFraction.substring(0, 6) : trimmedFraction}';
  }
}
