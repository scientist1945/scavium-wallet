class TransactionSendResult {
  final String txHash;
  final bool confirmed;

  const TransactionSendResult({required this.txHash, required this.confirmed});
}
