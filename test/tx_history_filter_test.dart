import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_filter.dart';
import 'package:scavium_wallet/features/assets/domain/tx_kind.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';

void main() {
  group('TxHistoryFilter', () {
    test('filters by status and kind without mutating entries', () {
      final nativePending = _entry(
        id: 'native-pending',
        kind: TxKind.nativeSend,
        status: TxStatus.pending,
      );
      final tokenPending = _entry(
        id: 'token-pending',
        kind: TxKind.erc20Send,
        status: TxStatus.pending,
      );
      final tokenConfirmed = _entry(
        id: 'token-confirmed',
        kind: TxKind.erc20Send,
        status: TxStatus.confirmed,
      );
      final entries = [nativePending, tokenPending, tokenConfirmed];

      final filtered = const TxHistoryFilter(
        status: TxHistoryStatusFilter.pending,
        kind: TxHistoryKindFilter.erc20Send,
      ).apply(entries);

      expect(filtered, [tokenPending]);
      expect(entries, [nativePending, tokenPending, tokenConfirmed]);
    });

    test('groups filtered entries by local day newest first', () {
      final older = _entry(
        id: 'older',
        kind: TxKind.nativeSend,
        status: TxStatus.confirmed,
        createdAt: DateTime.utc(2026, 4, 30, 12),
      );
      final newer = _entry(
        id: 'newer',
        kind: TxKind.nativeSend,
        status: TxStatus.confirmed,
        createdAt: DateTime.utc(2026, 5, 1, 12),
      );
      final hidden = _entry(
        id: 'hidden',
        kind: TxKind.erc20Send,
        status: TxStatus.confirmed,
        createdAt: DateTime.utc(2026, 5, 1, 13),
      );

      final groups = const TxHistoryFilter(
        kind: TxHistoryKindFilter.nativeSend,
      ).groupByLocalDay([older, hidden, newer]);

      expect(groups, hasLength(2));
      expect(groups.first.entries, [newer]);
      expect(groups.last.entries, [older]);
    });
  });
}

TxHistoryEntry _entry({
  required String id,
  required TxKind kind,
  required TxStatus status,
  DateTime? createdAt,
}) {
  return TxHistoryEntry(
    id: id,
    kind: kind,
    status: status,
    symbol: kind == TxKind.nativeSend ? 'SCV' : 'TEST',
    tokenAddress:
        kind == TxKind.nativeSend
            ? null
            : '0x1111111111111111111111111111111111111111',
    toAddress: '0x2222222222222222222222222222222222222222',
    amountDisplay: '1',
    txHash: '0x$id',
    createdAt: createdAt ?? DateTime.utc(2026, 5, 1),
  );
}
