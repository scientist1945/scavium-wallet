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

  TokenInfo normalized() {
    return TokenInfo(
      contractAddress: normalizeContractAddress(contractAddress),
      name: name.trim().isEmpty ? 'Unknown Token' : name.trim(),
      symbol: symbol.trim().isEmpty ? 'TOKEN' : symbol.trim(),
      decimals: decimals,
    );
  }

  static String normalizeContractAddress(String value) {
    final trimmed = value.trim();
    if (!isValidContractAddress(trimmed)) {
      throw FormatException('Invalid ERC-20 contract address');
    }
    return '0x${trimmed.substring(2).toLowerCase()}';
  }

  static bool isValidContractAddress(String value) {
    return RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value.trim());
  }

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
    ).normalized();
  }
}
