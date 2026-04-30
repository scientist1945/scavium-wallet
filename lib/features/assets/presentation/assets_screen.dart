import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/features/assets/application/assets_controller.dart';
import 'package:scavium_wallet/features/assets/domain/asset_account_context.dart';
import 'package:scavium_wallet/features/assets/domain/asset_item.dart';
import 'package:scavium_wallet/features/assets/domain/asset_kind.dart';
import 'package:scavium_wallet/features/assets/domain/portfolio_summary.dart';
import 'package:scavium_wallet/shared/widgets/feedback/state_message.dart';
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
        data: (items) {
          if (items.isEmpty) {
            return const StateMessage(
              icon: Icons.account_balance_wallet_outlined,
              title: 'No assets available',
              subtitle: 'Your assets will appear here once loaded.',
            );
          }

          return RefreshIndicator(
            onRefresh:
                () =>
                    ref.read(assetsControllerProvider.notifier).refreshAssets(),
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: items.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _PortfolioSummaryCard(
                    summary: PortfolioSummary.fromAssets(items),
                    accountContext: items.first.accountContext,
                  );
                }

                final item = items[index - 1];
                return _AssetTile(item: item);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (e, _) => StateMessage(
              icon: Icons.error_outline,
              title: 'Error loading assets',
              subtitle: '$e',
            ),
      ),
    );
  }
}

class _PortfolioSummaryCard extends StatelessWidget {
  final PortfolioSummary summary;
  final AssetAccountContext? accountContext;

  const _PortfolioSummaryCard({
    required this.summary,
    required this.accountContext,
  });

  @override
  Widget build(BuildContext context) {
    return ScaviumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portfolio summary',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _SummaryMetric(
                  label: 'Assets',
                  value: summary.totalAssets.toString(),
                ),
              ),
              Expanded(
                child: _SummaryMetric(
                  label: 'With balance',
                  value: summary.nonZeroAssetCount.toString(),
                ),
              ),
              Expanded(
                child: _SummaryMetric(
                  label: 'Tokens',
                  value: summary.erc20AssetCount.toString(),
                ),
              ),
            ],
          ),
          if (accountContext != null) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Text(
              accountContext!.displayName,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              accountContext!.shortAddress,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 2),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
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
