import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';

abstract class TxHistoryRepository {
  Future<List<TxHistoryEntry>> getEntries();
  Future<void> saveEntries(List<TxHistoryEntry> entries);
  Future<void> addEntry(TxHistoryEntry entry);
  Future<void> updateEntry(TxHistoryEntry entry);
  Future<void> clear();
}
