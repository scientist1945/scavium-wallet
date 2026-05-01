import 'package:scavium_wallet/features/assets/domain/tx_kind.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';

class TxHistoryEntry {
  final String id;
  final TxKind kind;
  final TxStatus status;
  final String symbol;
  final String? tokenAddress;
  final String toAddress;
  final String amountDisplay;
  final String txHash;
  final DateTime createdAt;

  const TxHistoryEntry({
    required this.id,
    required this.kind,
    required this.status,
    required this.symbol,
    required this.tokenAddress,
    required this.toAddress,
    required this.amountDisplay,
    required this.txHash,
    required this.createdAt,
  });

  TxHistoryEntry copyWith({
    String? id,
    TxKind? kind,
    TxStatus? status,
    String? symbol,
    String? tokenAddress,
    String? toAddress,
    String? amountDisplay,
    String? txHash,
    DateTime? createdAt,
  }) {
    return TxHistoryEntry(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      status: status ?? this.status,
      symbol: symbol ?? this.symbol,
      tokenAddress: tokenAddress ?? this.tokenAddress,
      toAddress: toAddress ?? this.toAddress,
      amountDisplay: amountDisplay ?? this.amountDisplay,
      txHash: txHash ?? this.txHash,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kind': kind.name,
      'status': status.name,
      'symbol': symbol,
      'tokenAddress': tokenAddress,
      'toAddress': toAddress,
      'amountDisplay': amountDisplay,
      'txHash': txHash,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TxHistoryEntry.fromJson(Map<String, dynamic> json) {
    final txHash = _readString(json['txHash']);
    final createdAt = _readDateTime(json['createdAt']);

    return TxHistoryEntry(
      id: _readString(json['id'], fallback: txHash),
      kind: _readKind(json['kind']),
      status: _readStatus(json['status']),
      symbol: _readString(json['symbol']),
      tokenAddress: _readNullableString(json['tokenAddress']),
      toAddress: _readString(json['toAddress']),
      amountDisplay: _readString(json['amountDisplay']),
      txHash: txHash,
      createdAt: createdAt,
    );
  }

  static TxKind _readKind(Object? value) {
    final raw = _readString(value);
    return TxKind.values.firstWhere(
      (kind) => kind.name == raw,
      orElse: () => TxKind.nativeSend,
    );
  }

  static TxStatus _readStatus(Object? value) {
    final raw = _readString(value);
    return TxStatus.values.firstWhere(
      (status) => status.name == raw,
      orElse: () => TxStatus.pending,
    );
  }

  static String _readString(Object? value, {String fallback = ''}) {
    if (value is String && value.trim().isNotEmpty) {
      return value;
    }
    return fallback;
  }

  static String? _readNullableString(Object? value) {
    if (value is String && value.trim().isNotEmpty) {
      return value;
    }
    return null;
  }

  static DateTime _readDateTime(Object? value) {
    if (value is String) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) {
        return parsed;
      }
    }
    return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
  }
}
