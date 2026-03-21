class ScaviumRpcStatus {
  final int activeIndex;
  final String activeRpcUrl;
  final List<String> rpcUrls;

  const ScaviumRpcStatus({
    required this.activeIndex,
    required this.activeRpcUrl,
    required this.rpcUrls,
  });
}
