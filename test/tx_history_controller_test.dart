import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/assets/application/tx_history_controller.dart';
import 'package:scavium_wallet/features/assets/data/tx_history_repository_impl.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_repository.dart';
import 'package:scavium_wallet/features/assets/domain/tx_kind.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';

void main() {
  group('TxHistoryController', () {
    test(
      'keeps pending entries pending when receipt is not available',
      () async {
        final repo = _FakeTxHistoryRepository([
          _entry(id: 'tx-1', status: TxStatus.pending),
        ]);
        final container = ProviderContainer(
          overrides: [
            txHistoryRepositoryProvider.overrideWithValue(repo),
            txReceiptReaderProvider.overrideWithValue((_) async => null),
          ],
        );
        addTearDown(container.dispose);

        await container.read(txHistoryControllerProvider.future);
        await container
            .read(txHistoryControllerProvider.notifier)
            .refreshStatuses();

        final entries =
            container.read(txHistoryControllerProvider).requireValue;

        expect(entries.single.status, TxStatus.pending);
        expect(repo.savedEntries.single.status, TxStatus.pending);
      },
    );

    test('does not refresh receipts when no entries are pending', () async {
      var receiptCalls = 0;
      final repo = _FakeTxHistoryRepository([
        _entry(id: 'tx-1', status: TxStatus.confirmed),
      ]);
      final container = ProviderContainer(
        overrides: [
          txHistoryRepositoryProvider.overrideWithValue(repo),
          txReceiptReaderProvider.overrideWithValue((_) async {
            receiptCalls++;
            return null;
          }),
        ],
      );
      addTearDown(container.dispose);

      await container.read(txHistoryControllerProvider.future);
      await container
          .read(txHistoryControllerProvider.notifier)
          .refreshStatuses();

      expect(receiptCalls, 0);
      expect(
        container.read(txHistoryControllerProvider).requireValue.single.status,
        TxStatus.confirmed,
      );
    });
  });
}

TxHistoryEntry _entry({required String id, required TxStatus status}) {
  return TxHistoryEntry(
    id: id,
    kind: TxKind.nativeSend,
    status: status,
    symbol: 'SCV',
    tokenAddress: null,
    toAddress: '0x2222222222222222222222222222222222222222',
    amountDisplay: '1',
    txHash: '0x$id',
    createdAt: DateTime.utc(2026, 5, 1),
  );
}

class _FakeTxHistoryRepository implements TxHistoryRepository {
  List<TxHistoryEntry> _entries;
  List<TxHistoryEntry> savedEntries;

  _FakeTxHistoryRepository(List<TxHistoryEntry> entries)
    : _entries = List<TxHistoryEntry>.from(entries),
      savedEntries = List<TxHistoryEntry>.from(entries);

  @override
  Future<void> addEntry(TxHistoryEntry entry) async {
    _entries = [entry, ..._entries];
    savedEntries = List<TxHistoryEntry>.from(_entries);
  }

  @override
  Future<void> clear() async {
    _entries = [];
    savedEntries = [];
  }

  @override
  Future<List<TxHistoryEntry>> getEntries() async {
    return List<TxHistoryEntry>.from(_entries);
  }

  @override
  Future<void> saveEntries(List<TxHistoryEntry> entries) async {
    _entries = List<TxHistoryEntry>.from(entries);
    savedEntries = List<TxHistoryEntry>.from(entries);
  }

  @override
  Future<void> updateEntry(TxHistoryEntry entry) async {
    final index = _entries.indexWhere((candidate) => candidate.id == entry.id);
    if (index < 0) {
      return;
    }
    _entries[index] = entry;
    savedEntries = List<TxHistoryEntry>.from(_entries);
  }
}
