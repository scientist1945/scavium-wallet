import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/domain/tx_kind.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';

void main() {
  group('TxHistoryEntry', () {
    test('reads current JSON shape', () {
      final entry = TxHistoryEntry.fromJson({
        'id': 'tx-1',
        'kind': 'erc20Send',
        'status': 'confirmed',
        'symbol': 'TEST',
        'tokenAddress': '0x1111111111111111111111111111111111111111',
        'toAddress': '0x2222222222222222222222222222222222222222',
        'amountDisplay': '1.5',
        'txHash': '0xhash',
        'createdAt': '2026-05-01T00:00:00.000Z',
      });

      expect(entry.id, 'tx-1');
      expect(entry.kind, TxKind.erc20Send);
      expect(entry.status, TxStatus.confirmed);
      expect(entry.symbol, 'TEST');
      expect(entry.txHash, '0xhash');
      expect(entry.createdAt, DateTime.parse('2026-05-01T00:00:00.000Z'));
    });

    test('keeps older partial entries readable with safe defaults', () {
      final entry = TxHistoryEntry.fromJson({
        'txHash': '0xlegacy',
        'createdAt': 'not-a-date',
      });

      expect(entry.id, '0xlegacy');
      expect(entry.kind, TxKind.nativeSend);
      expect(entry.status, TxStatus.pending);
      expect(entry.symbol, '');
      expect(entry.tokenAddress, isNull);
      expect(entry.toAddress, '');
      expect(entry.amountDisplay, '');
      expect(entry.txHash, '0xlegacy');
      expect(
        entry.createdAt,
        DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      );
    });

    test('unknown status remains pending instead of failed', () {
      final entry = TxHistoryEntry.fromJson({
        'id': 'tx-2',
        'kind': 'nativeSend',
        'status': 'unresolved',
        'txHash': '0xpending',
      });

      expect(entry.status, TxStatus.pending);
    });
  });
}
