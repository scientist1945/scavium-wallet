class NetworkInfo {
  final int chainId;
  final BigInt gasPriceWei;
  final int latestBlock;

  const NetworkInfo({
    required this.chainId,
    required this.gasPriceWei,
    required this.latestBlock,
  });
}
