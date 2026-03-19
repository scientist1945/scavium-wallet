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
    return TxHistoryEntry(
      id: json['id'] as String,
      kind: TxKind.values.firstWhere((e) => e.name == json['kind']),
      status: TxStatus.values.firstWhere((e) => e.name == json['status']),
      symbol: json['symbol'] as String,
      tokenAddress: json['tokenAddress'] as String?,
      toAddress: json['toAddress'] as String,
      amountDisplay: json['amountDisplay'] as String,
      txHash: json['txHash'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
