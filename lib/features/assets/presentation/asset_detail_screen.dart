import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/features/assets/application/token_registry_controller.dart';
import 'package:scavium_wallet/features/assets/domain/asset_item.dart';
import 'package:scavium_wallet/features/assets/domain/asset_kind.dart';
import 'package:scavium_wallet/features/assets/domain/token_info.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class AssetDetailScreen extends ConsumerWidget {
  final AssetItem asset;

  const AssetDetailScreen({super.key, required this.asset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaviumScaffold(
      appBar: AppBar(
        title: Text(asset.symbol),
        actions: [
          if (asset.kind == AssetKind.erc20)
            IconButton(
              onPressed: () async {
                await ref
                    .read(tokenRegistryControllerProvider.notifier)
                    .removeToken(asset.contractAddress!);
                if (context.mounted) {
                  context.pop();
                }
              },
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ScaviumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Balance: ${asset.displayBalance} ${asset.symbol}'),
                const SizedBox(height: 8),
                Text('Decimals: ${asset.decimals}'),
                if (asset.contractAddress != null) ...[
                  const SizedBox(height: 8),
                  SelectableText('Contract: ${asset.contractAddress}'),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          ScaviumPrimaryButton(
            text: 'Send',
            onPressed: () {
              if (asset.kind == AssetKind.native) {
                context.push(RouteNames.send);
              } else {
                context.push(
                  RouteNames.sendToken,
                  extra: TokenInfo(
                    contractAddress: asset.contractAddress!,
                    name: asset.title,
                    symbol: asset.symbol,
                    decimals: asset.decimals,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
