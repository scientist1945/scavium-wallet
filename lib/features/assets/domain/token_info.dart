class TokenInfo {
  final String contractAddress;
  final String name;
  final String symbol;
  final int decimals;

  const TokenInfo({
    required this.contractAddress,
    required this.name,
    required this.symbol,
    required this.decimals,
  });

  Map<String, dynamic> toJson() {
    return {
      'contractAddress': contractAddress,
      'name': name,
      'symbol': symbol,
      'decimals': decimals,
    };
  }

  factory TokenInfo.fromJson(Map<String, dynamic> json) {
    return TokenInfo(
      contractAddress: json['contractAddress'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimals: json['decimals'] as int,
    );
  }
}
