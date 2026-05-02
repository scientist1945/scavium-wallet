import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/domain/tx_kind.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';

enum TxHistoryStatusFilter { all, pending, confirmed, failed }

enum TxHistoryKindFilter { all, nativeSend, erc20Send }

class TxHistoryDayGroup {
  final DateTime day;
  final List<TxHistoryEntry> entries;

  const TxHistoryDayGroup({required this.day, required this.entries});
}

class TxHistoryFilter {
  final TxHistoryStatusFilter status;
  final TxHistoryKindFilter kind;

  const TxHistoryFilter({
    this.status = TxHistoryStatusFilter.all,
    this.kind = TxHistoryKindFilter.all,
  });

  bool get isDefault =>
      status == TxHistoryStatusFilter.all && kind == TxHistoryKindFilter.all;

  List<TxHistoryEntry> apply(List<TxHistoryEntry> entries) {
    return entries.where(matches).toList(growable: false);
  }

  bool matches(TxHistoryEntry entry) {
    return _matchesStatus(entry) && _matchesKind(entry);
  }

  List<TxHistoryDayGroup> groupByLocalDay(List<TxHistoryEntry> entries) {
    final filtered = apply(entries);
    final groups = <DateTime, List<TxHistoryEntry>>{};

    for (final entry in filtered) {
      final local = entry.createdAt.toLocal();
      final day = DateTime(local.year, local.month, local.day);
      groups.putIfAbsent(day, () => <TxHistoryEntry>[]).add(entry);
    }

    return groups.entries
      .map((entry) {
        final items = List<TxHistoryEntry>.from(entry.value)
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return TxHistoryDayGroup(day: entry.key, entries: items);
      })
      .toList(growable: false)..sort((a, b) => b.day.compareTo(a.day));
  }

  bool _matchesStatus(TxHistoryEntry entry) {
    return switch (status) {
      TxHistoryStatusFilter.all => true,
      TxHistoryStatusFilter.pending => entry.status == TxStatus.pending,
      TxHistoryStatusFilter.confirmed => entry.status == TxStatus.confirmed,
      TxHistoryStatusFilter.failed => entry.status == TxStatus.failed,
    };
  }

  bool _matchesKind(TxHistoryEntry entry) {
    return switch (kind) {
      TxHistoryKindFilter.all => true,
      TxHistoryKindFilter.nativeSend => entry.kind == TxKind.nativeSend,
      TxHistoryKindFilter.erc20Send => entry.kind == TxKind.erc20Send,
    };
  }
}
