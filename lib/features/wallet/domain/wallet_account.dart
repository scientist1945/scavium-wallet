class WalletAccount {
  final String name;
  final String address;
  final int accountIndex;
  final bool isImportedByPrivateKey;

  const WalletAccount({
    required this.name,
    required this.address,
    required this.accountIndex,
    required this.isImportedByPrivateKey,
  });

  WalletAccount copyWith({
    String? name,
    String? address,
    int? accountIndex,
    bool? isImportedByPrivateKey,
  }) {
    return WalletAccount(
      name: name ?? this.name,
      address: address ?? this.address,
      accountIndex: accountIndex ?? this.accountIndex,
      isImportedByPrivateKey:
          isImportedByPrivateKey ?? this.isImportedByPrivateKey,
    );
  }
}
