import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/features/assets/application/assets_controller.dart';
import 'package:scavium_wallet/features/assets/domain/asset_item.dart';
import 'package:scavium_wallet/features/assets/domain/asset_kind.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class AssetsScreen extends ConsumerWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetsState = ref.watch(assetsControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(
        title: const Text('Assets'),
        actions: [
          IconButton(
            onPressed: () => context.push(RouteNames.addToken),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed:
                () =>
                    ref.read(assetsControllerProvider.notifier).refreshAssets(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      child: assetsState.when(
        data:
            (items) => ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                return _AssetTile(item: item);
              },
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading assets: $e')),
      ),
    );
  }
}

class _AssetTile extends StatelessWidget {
  final AssetItem item;

  const _AssetTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return ScaviumCard(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(child: Text(item.symbol.characters.first)),
        title: Text(item.title),
        subtitle: Text(
          item.kind == AssetKind.native
              ? 'Native asset'
              : item.contractAddress ?? '',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              item.displayBalance,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(item.symbol),
          ],
        ),
        onTap: () {
          context.push(RouteNames.assetDetail, extra: item);
        },
      ),
    );
  }
}
