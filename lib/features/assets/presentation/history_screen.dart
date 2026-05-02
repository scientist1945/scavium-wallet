import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/features/assets/application/tx_history_controller.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_filter.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';
import 'package:scavium_wallet/shared/widgets/feedback/state_message.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  var _statusFilter = TxHistoryStatusFilter.all;
  var _kindFilter = TxHistoryKindFilter.all;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(txHistoryControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            onPressed:
                () =>
                    ref
                        .read(txHistoryControllerProvider.notifier)
                        .refreshStatuses(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      child: state.when(
        data: (items) {
          final filter = TxHistoryFilter(
            status: _statusFilter,
            kind: _kindFilter,
          );
          final groups = filter.groupByLocalDay(items);

          return RefreshIndicator(
            onRefresh:
                () =>
                    ref
                        .read(txHistoryControllerProvider.notifier)
                        .refreshStatuses(),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'This history currently shows locally tracked outgoing transactions and their receipt status. Incoming transactions require explorer/indexer integration.',
                ),
                const SizedBox(height: 16),
                _HistoryFilters(
                  status: _statusFilter,
                  kind: _kindFilter,
                  onStatusChanged: (value) {
                    setState(() => _statusFilter = value);
                  },
                  onKindChanged: (value) {
                    setState(() => _kindFilter = value);
                  },
                ),
                const SizedBox(height: 16),
                if (items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: StateMessage(
                      icon: Icons.receipt_long,
                      title: 'No transactions yet',
                      subtitle:
                          'This view shows locally tracked outgoing transactions created from this wallet.',
                    ),
                  )
                else if (groups.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: StateMessage(
                      icon: Icons.filter_alt_off,
                      title: 'No matching activity',
                      subtitle:
                          'The current filters hide all local outgoing transactions. Clear or change filters to see more.',
                    ),
                  )
                else
                  ...groups.expand((group) {
                    return [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          _formatDay(group.day),
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      ...group.entries.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _HistoryEntryCard(item: item),
                        );
                      }),
                    ];
                  }),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (e, _) => StateMessage(
              icon: Icons.error_outline,
              title: 'Error loading local outgoing history',
              subtitle:
                  'Receipt status could not be loaded right now. Existing local entries were not modified. $e',
            ),
      ),
    );
  }

  String _formatDay(DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (day == today) {
      return 'Today';
    }
    if (day == yesterday) {
      return 'Yesterday';
    }
    return '${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
  }
}

class _HistoryFilters extends StatelessWidget {
  final TxHistoryStatusFilter status;
  final TxHistoryKindFilter kind;
  final ValueChanged<TxHistoryStatusFilter> onStatusChanged;
  final ValueChanged<TxHistoryKindFilter> onKindChanged;

  const _HistoryFilters({
    required this.status,
    required this.kind,
    required this.onStatusChanged,
    required this.onKindChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ScaviumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: TxHistoryStatusFilter.values
                .map((value) {
                  return ChoiceChip(
                    label: Text(_statusLabel(value)),
                    selected: status == value,
                    onSelected: (_) => onStatusChanged(value),
                  );
                })
                .toList(growable: false),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: TxHistoryKindFilter.values
                .map((value) {
                  return ChoiceChip(
                    label: Text(_kindLabel(value)),
                    selected: kind == value,
                    onSelected: (_) => onKindChanged(value),
                  );
                })
                .toList(growable: false),
          ),
        ],
      ),
    );
  }

  String _statusLabel(TxHistoryStatusFilter value) {
    return switch (value) {
      TxHistoryStatusFilter.all => 'All',
      TxHistoryStatusFilter.pending => 'Pending',
      TxHistoryStatusFilter.confirmed => 'Confirmed',
      TxHistoryStatusFilter.failed => 'Failed',
    };
  }

  String _kindLabel(TxHistoryKindFilter value) {
    return switch (value) {
      TxHistoryKindFilter.all => 'All types',
      TxHistoryKindFilter.nativeSend => 'Native',
      TxHistoryKindFilter.erc20Send => 'ERC-20',
    };
  }
}

class _HistoryEntryCard extends StatelessWidget {
  final TxHistoryEntry item;

  const _HistoryEntryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return ScaviumCard(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          item.status == TxStatus.confirmed
              ? Icons.check_circle_outline
              : item.status == TxStatus.failed
              ? Icons.error_outline
              : Icons.schedule,
        ),
        title: Text('${item.amountDisplay} ${item.symbol}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('To: ${item.toAddress}'),
            Text('Hash: ${item.txHash}'),
            Text(item.createdAt.toLocal().toString()),
          ],
        ),
        trailing: Text(item.status.name),
        onTap: () {
          context.push(RouteNames.transactionDetail, extra: item);
        },
      ),
    );
  }
}
