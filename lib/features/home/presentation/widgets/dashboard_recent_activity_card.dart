import 'package:flutter/material.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';

class DashboardRecentActivityCard extends StatelessWidget {
  final List<TxHistoryEntry> entries;
  final VoidCallback onOpenActivity;
  final ValueChanged<TxHistoryEntry> onOpenEntry;

  const DashboardRecentActivityCard({
    super.key,
    required this.entries,
    required this.onOpenActivity,
    required this.onOpenEntry,
  });

  @override
  Widget build(BuildContext context) {
    final recent = entries.take(3).toList(growable: false);

    return ScaviumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Recent activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              TextButton(
                onPressed: onOpenActivity,
                child: const Text('View all'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (recent.isEmpty)
            const Text('No local outgoing transactions yet')
          else
            ...recent.map(
              (entry) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('${entry.amountDisplay} ${entry.symbol}'),
                subtitle: Text(entry.toAddress),
                trailing: Text(entry.status.name),
                onTap: () => onOpenEntry(entry),
              ),
            ),
        ],
      ),
    );
  }
}
