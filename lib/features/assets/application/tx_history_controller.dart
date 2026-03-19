import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/assets/data/tx_history_repository_impl.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';

final txHistoryControllerProvider =
    AsyncNotifierProvider<TxHistoryController, List<TxHistoryEntry>>(
      TxHistoryController.new,
    );

class TxHistoryController extends AsyncNotifier<List<TxHistoryEntry>> {
  @override
  Future<List<TxHistoryEntry>> build() async {
    return ref.read(txHistoryRepositoryProvider).getEntries();
  }

  Future<void> addEntry(TxHistoryEntry entry) async {
    final repo = ref.read(txHistoryRepositoryProvider);
    await repo.addEntry(entry);
    state = AsyncData(await repo.getEntries());
  }

  Future<void> refreshStatuses() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repo = ref.read(txHistoryRepositoryProvider);
      final rpc = ref.read(scaviumRpcServiceProvider);
      final entries = await repo.getEntries();

      final updated = <TxHistoryEntry>[];

      for (final item in entries) {
        if (item.status != TxStatus.pending) {
          updated.add(item);
          continue;
        }

        final receipt = await rpc.getReceipt(item.txHash);
        if (receipt == null) {
          updated.add(item);
          continue;
        }

        updated.add(
          item.copyWith(
            status:
                (receipt.status ?? true) ? TxStatus.confirmed : TxStatus.failed,
          ),
        );
      }

      await repo.saveEntries(updated);
      return repo.getEntries();
    });
  }
}
