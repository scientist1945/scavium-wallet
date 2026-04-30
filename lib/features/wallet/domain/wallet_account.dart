class WalletAccount {
  final String id;
  final String name;
  final String? label;
  final String address;
  final int accountIndex;
  final bool isImportedByPrivateKey;
  final bool isDefault;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  WalletAccount({
    String? id,
    required this.name,
    String? label,
    required this.address,
    required this.accountIndex,
    required this.isImportedByPrivateKey,
    this.isDefault = false,
    this.isActive = false,
    this.createdAt,
    this.updatedAt,
  }) : id = id ?? legacyIdFor(address: address, accountIndex: accountIndex),
       label = label ?? name;

  static String legacyIdFor({
    required String address,
    required int accountIndex,
  }) {
    final normalizedAddress = address.trim().toLowerCase();
    return '$normalizedAddress:$accountIndex';
  }

  WalletAccount copyWith({
    String? id,
    String? name,
    String? label,
    String? address,
    int? accountIndex,
    bool? isImportedByPrivateKey,
    bool? isDefault,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WalletAccount(
      id: id ?? this.id,
      name: name ?? this.name,
      label: label ?? this.label,
      address: address ?? this.address,
      accountIndex: accountIndex ?? this.accountIndex,
      isImportedByPrivateKey:
          isImportedByPrivateKey ?? this.isImportedByPrivateKey,
      isDefault: isDefault ?? this.isDefault,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
