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

  factory WalletAccount.fromJson(Map<String, dynamic> json) {
    final address = (json['address'] as String?)?.trim() ?? '';
    final accountIndex = _readInt(json['accountIndex']) ?? 0;
    final name = (json['name'] as String?)?.trim();

    return WalletAccount(
      id:
          (json['id'] as String?)?.trim().isEmpty ?? true
              ? null
              : (json['id'] as String).trim(),
      name: name == null || name.isEmpty ? 'Account ${accountIndex + 1}' : name,
      label: (json['label'] as String?)?.trim(),
      address: address,
      accountIndex: accountIndex,
      isImportedByPrivateKey: json['isImportedByPrivateKey'] == true,
      isDefault: json['isDefault'] == true,
      isActive: json['isActive'] == true,
      createdAt: _readDateTime(json['createdAt']),
      updatedAt: _readDateTime(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'label': label,
      'address': address,
      'accountIndex': accountIndex,
      'isImportedByPrivateKey': isImportedByPrivateKey,
      'isDefault': isDefault,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
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

  static int? _readInt(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static DateTime? _readDateTime(Object? value) {
    if (value is! String || value.trim().isEmpty) {
      return null;
    }
    return DateTime.tryParse(value.trim());
  }
}
