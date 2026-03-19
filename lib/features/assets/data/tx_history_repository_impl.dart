import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/providers/service_providers.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_repository.dart';

final txHistoryRepositoryProvider = Provider<TxHistoryRepository>((ref) {
  return TxHistoryRepositoryImpl(ref);
});

class TxHistoryRepositoryImpl implements TxHistoryRepository {
  final Ref ref;

  TxHistoryRepositoryImpl(this.ref);

  @override
  Future<List<TxHistoryEntry>> getEntries() async {
    final storage = ref.read(localStorageProvider);
    final raw = await storage.getString(StorageKeys.txHistoryJson);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => TxHistoryEntry.fromJson(Map<String, dynamic>.from(e)))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<void> saveEntries(List<TxHistoryEntry> entries) async {
    final storage = ref.read(localStorageProvider);
    final raw = jsonEncode(entries.map((e) => e.toJson()).toList());
    await storage.setString(StorageKeys.txHistoryJson, raw);
  }

  @override
  Future<void> addEntry(TxHistoryEntry entry) async {
    final entries = await getEntries();
    entries.insert(0, entry);
    await saveEntries(entries);
  }

  @override
  Future<void> updateEntry(TxHistoryEntry entry) async {
    final entries = await getEntries();
    final idx = entries.indexWhere((e) => e.id == entry.id);
    if (idx >= 0) {
      entries[idx] = entry;
      await saveEntries(entries);
    }
  }

  @override
  Future<void> clear() async {
    final storage = ref.read(localStorageProvider);
    await storage.remove(StorageKeys.txHistoryJson);
  }
}
