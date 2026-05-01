import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/domain/tx_kind.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';
import 'package:scavium_wallet/features/assets/presentation/transaction_detail_screen.dart';

void main() {
  testWidgets('renders transaction receipt-oriented details', (tester) async {
    final entry = TxHistoryEntry(
      id: 'tx-1',
      kind: TxKind.erc20Send,
      status: TxStatus.pending,
      symbol: 'TEST',
      tokenAddress: '0x1111111111111111111111111111111111111111',
      toAddress: '0x2222222222222222222222222222222222222222',
      amountDisplay: '2.5',
      txHash: '0xabc123',
      createdAt: DateTime.utc(2026, 5, 1, 12),
    );

    await tester.pumpWidget(
      MaterialApp(home: TransactionDetailScreen(entry: entry)),
    );

    expect(find.text('Transaction detail'), findsOneWidget);
    expect(find.text('2.5 TEST'), findsOneWidget);
    expect(find.text('Pending'), findsWidgets);
    expect(find.text('ERC-20 send'), findsOneWidget);
    expect(
      find.text('0x2222222222222222222222222222222222222222'),
      findsOneWidget,
    );
    expect(
      find.text('0x1111111111111111111111111111111111111111'),
      findsOneWidget,
    );
    expect(find.text('0xabc123'), findsOneWidget);
    expect(
      find.textContaining('No final receipt has been found yet'),
      findsOneWidget,
    );
    expect(find.text('Open in explorer'), findsOneWidget);
  });
}
