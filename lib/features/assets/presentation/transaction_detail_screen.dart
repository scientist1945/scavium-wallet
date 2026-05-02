import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/domain/tx_kind.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TxHistoryEntry entry;

  const TransactionDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final explorerUrl = '${AppConfig.current.txExplorerPath}/${entry.txHash}';
    final colorScheme = Theme.of(context).colorScheme;
    final statusColor = _statusColor(context, entry.status);

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Transaction detail')),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ScaviumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _statusIcon(entry.status),
                      color: statusColor,
                      size: ScavoIconSize.inline,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${entry.amountDisplay} ${entry.symbol}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Chip(
                      label: Text(_statusLabel(entry.status)),
                      backgroundColor:
                          entry.status == TxStatus.confirmed
                              ? ScavoColors.semanticSuccess
                              : colorScheme.surface,
                      labelStyle: TextStyle(
                        color:
                            entry.status == TxStatus.confirmed
                                ? colorScheme.onPrimary
                                : statusColor,
                      ),
                      side: BorderSide(color: statusColor),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(_receiptExplanation(entry.status)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ScaviumCard(
            child: Column(
              children: [
                _DetailRow(label: 'Kind', value: _kindLabel(entry.kind)),
                _DetailRow(label: 'Status', value: _statusLabel(entry.status)),
                _DetailRow(label: 'To', value: entry.toAddress),
                _DetailRow(label: 'Amount', value: entry.amountDisplay),
                _DetailRow(label: 'Symbol', value: entry.symbol),
                if (entry.tokenAddress != null)
                  _DetailRow(label: 'Token', value: entry.tokenAddress!),
                _DetailRow(label: 'Hash', value: entry.txHash),
                _DetailRow(
                  label: 'Timestamp',
                  value: entry.createdAt.toLocal().toString(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () async {
              await launchUrl(
                Uri.parse(explorerUrl),
                mode: LaunchMode.externalApplication,
              );
            },
            icon: const Icon(
              LucideIcons.externalLink,
              size: ScavoIconSize.inline,
            ),
            label: const Text('Open in explorer'),
          ),
        ],
      ),
    );
  }

  IconData _statusIcon(TxStatus status) {
    return switch (status) {
      TxStatus.confirmed => LucideIcons.checkCircle,
      TxStatus.failed => LucideIcons.alertCircle,
      TxStatus.pending => LucideIcons.clock,
    };
  }

  Color _statusColor(BuildContext context, TxStatus status) {
    final colorScheme = Theme.of(context).colorScheme;

    return switch (status) {
      TxStatus.confirmed => ScavoColors.semanticSuccess,
      TxStatus.failed => colorScheme.error,
      TxStatus.pending => colorScheme.primary,
    };
  }

  String _statusLabel(TxStatus status) {
    return switch (status) {
      TxStatus.confirmed => 'Confirmed',
      TxStatus.failed => 'Failed',
      TxStatus.pending => 'Pending',
    };
  }

  String _kindLabel(TxKind kind) {
    return switch (kind) {
      TxKind.nativeSend => 'Native send',
      TxKind.erc20Send => 'ERC-20 send',
    };
  }

  String _receiptExplanation(TxStatus status) {
    return switch (status) {
      TxStatus.confirmed =>
        'A receipt was found and the transaction was confirmed by the network.',
      TxStatus.failed =>
        'A receipt was found, but the network reported this transaction as failed.',
      TxStatus.pending =>
        'No final receipt has been found yet. The transaction remains pending until a receipt confirms or fails it.',
    };
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(child: SelectableText(value)),
        ],
      ),
    );
  }
}
