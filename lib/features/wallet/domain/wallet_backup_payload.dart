import 'package:scavium_wallet/features/wallet/domain/wallet_account.dart';

class WalletBackupPayload {
  final String format;
  final int version;
  final String createdAt;
  final WalletBackupWallet wallet;
  final List<WalletBackupAccount> accounts;
  final String? activeAccountId;
  final String? defaultAccountId;

  const WalletBackupPayload({
    required this.format,
    required this.version,
    required this.createdAt,
    required this.wallet,
    this.accounts = const <WalletBackupAccount>[],
    this.activeAccountId,
    this.defaultAccountId,
  });

  factory WalletBackupPayload.v1({
    required WalletBackupWallet wallet,
    required DateTime createdAt,
  }) {
    return WalletBackupPayload(
      format: 'scavium_wallet_backup',
      version: 1,
      createdAt: createdAt.toUtc().toIso8601String(),
      wallet: wallet,
    );
  }

  factory WalletBackupPayload.v2({
    required WalletBackupWallet wallet,
    required List<WalletBackupAccount> accounts,
    required String activeAccountId,
    required String defaultAccountId,
    required DateTime createdAt,
  }) {
    return WalletBackupPayload(
      format: 'scavium_wallet_backup',
      version: 2,
      createdAt: createdAt.toUtc().toIso8601String(),
      wallet: wallet,
      accounts: accounts,
      activeAccountId: activeAccountId,
      defaultAccountId: defaultAccountId,
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'format': format,
      'version': version,
      'created_at': createdAt,
      'wallet': wallet.toJson(),
    };

    if (version >= 2) {
      json.addAll({
        'accounts': accounts.map((account) => account.toJson()).toList(),
        'active_account_id': activeAccountId,
        'default_account_id': defaultAccountId,
      });
    }

    return json;
  }

  factory WalletBackupPayload.fromJson(Map<String, dynamic> json) {
    final rawAccounts = json['accounts'];

    return WalletBackupPayload(
      format: json['format'] as String? ?? '',
      version: json['version'] as int? ?? 0,
      createdAt: json['created_at'] as String? ?? '',
      wallet: WalletBackupWallet.fromJson(
        Map<String, dynamic>.from(json['wallet'] as Map),
      ),
      accounts:
          rawAccounts is List
              ? rawAccounts
                  .whereType<Map>()
                  .map(
                    (account) => WalletBackupAccount.fromJson(
                      Map<String, dynamic>.from(account),
                    ),
                  )
                  .toList(growable: false)
              : const <WalletBackupAccount>[],
      activeAccountId: json['active_account_id'] as String?,
      defaultAccountId: json['default_account_id'] as String?,
    );
  }

  void validate() {
    if (format != 'scavium_wallet_backup') {
      throw Exception('Invalid backup payload format');
    }

    if (version != 1 && version != 2) {
      throw Exception('Unsupported backup payload version');
    }

    if (createdAt.trim().isEmpty) {
      throw Exception('Invalid backup creation timestamp');
    }

    wallet.validate();

    if (version == 2) {
      _validateAccountAwarePayload();
    }
  }

  void _validateAccountAwarePayload() {
    if (accounts.isEmpty) {
      throw Exception('Backup account list is empty');
    }

    final ids = <String>{};
    var hasWalletAddress = false;

    for (final account in accounts) {
      account.validate();

      if (!ids.add(account.id)) {
        throw Exception('Duplicate backup account id');
      }

      if (_sameAddress(account.address, wallet.address)) {
        hasWalletAddress = true;
      }
    }

    if (!hasWalletAddress) {
      throw Exception('Backup accounts do not include wallet address');
    }

    if (activeAccountId == null ||
        activeAccountId!.trim().isEmpty ||
        !ids.contains(activeAccountId)) {
      throw Exception('Invalid active backup account id');
    }

    if (defaultAccountId == null ||
        defaultAccountId!.trim().isEmpty ||
        !ids.contains(defaultAccountId)) {
      throw Exception('Invalid default backup account id');
    }
  }

  bool _sameAddress(String left, String right) {
    return left.trim().toLowerCase() == right.trim().toLowerCase();
  }
}

class WalletBackupWallet {
  final String type;
  final String? mnemonic;
  final String? privateKey;
  final String address;
  final String accountName;

  const WalletBackupWallet({
    required this.type,
    required this.mnemonic,
    required this.privateKey,
    required this.address,
    required this.accountName,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'mnemonic': mnemonic,
      'private_key': privateKey,
      'address': address,
      'account_name': accountName,
    };
  }

  factory WalletBackupWallet.fromJson(Map<String, dynamic> json) {
    return WalletBackupWallet(
      type: json['type'] as String? ?? '',
      mnemonic: json['mnemonic'] as String?,
      privateKey: json['private_key'] as String?,
      address: json['address'] as String? ?? '',
      accountName: json['account_name'] as String? ?? '',
    );
  }

  void validate() {
    if (type != 'mnemonic' && type != 'privateKey') {
      throw Exception('Invalid wallet backup type');
    }

    if (address.trim().isEmpty) {
      throw Exception('Invalid wallet backup address');
    }

    if (accountName.trim().isEmpty) {
      throw Exception('Invalid wallet backup account name');
    }

    if (type == 'mnemonic') {
      if (mnemonic == null || mnemonic!.trim().isEmpty) {
        throw Exception('Mnemonic backup is missing mnemonic');
      }
      if (privateKey != null && privateKey!.trim().isNotEmpty) {
        throw Exception('Mnemonic backup should not contain private key');
      }
    }

    if (type == 'privateKey') {
      if (privateKey == null || privateKey!.trim().isEmpty) {
        throw Exception('Private key backup is missing private key');
      }
      if (mnemonic != null && mnemonic!.trim().isNotEmpty) {
        throw Exception('Private key backup should not contain mnemonic');
      }
    }
  }
}

class WalletBackupAccount {
  final String id;
  final String name;
  final String? label;
  final String address;
  final int accountIndex;
  final bool isImportedByPrivateKey;
  final bool isDefault;
  final bool isActive;
  final String? createdAt;
  final String? updatedAt;

  const WalletBackupAccount({
    required this.id,
    required this.name,
    required this.label,
    required this.address,
    required this.accountIndex,
    required this.isImportedByPrivateKey,
    required this.isDefault,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WalletBackupAccount.fromWalletAccount(WalletAccount account) {
    return WalletBackupAccount(
      id: account.id,
      name: account.name,
      label: account.label,
      address: account.address,
      accountIndex: account.accountIndex,
      isImportedByPrivateKey: account.isImportedByPrivateKey,
      isDefault: account.isDefault,
      isActive: account.isActive,
      createdAt: account.createdAt?.toUtc().toIso8601String(),
      updatedAt: account.updatedAt?.toUtc().toIso8601String(),
    );
  }

  factory WalletBackupAccount.fromJson(Map<String, dynamic> json) {
    return WalletBackupAccount(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      label: json['label'] as String?,
      address: json['address'] as String? ?? '',
      accountIndex: _readInt(json['account_index']) ?? 0,
      isImportedByPrivateKey: json['is_imported_by_private_key'] == true,
      isDefault: json['is_default'] == true,
      isActive: json['is_active'] == true,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'label': label,
      'address': address,
      'account_index': accountIndex,
      'is_imported_by_private_key': isImportedByPrivateKey,
      'is_default': isDefault,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  WalletAccount toWalletAccount() {
    return WalletAccount(
      id: id,
      name: name,
      label: label,
      address: address,
      accountIndex: accountIndex,
      isImportedByPrivateKey: isImportedByPrivateKey,
      isDefault: isDefault,
      isActive: isActive,
      createdAt: _readDateTime(createdAt),
      updatedAt: _readDateTime(updatedAt),
    );
  }

  void validate() {
    if (id.trim().isEmpty) {
      throw Exception('Invalid backup account id');
    }

    if (name.trim().isEmpty) {
      throw Exception('Invalid backup account name');
    }

    if (address.trim().isEmpty) {
      throw Exception('Invalid backup account address');
    }

    if (accountIndex < 0) {
      throw Exception('Invalid backup account index');
    }

    if (createdAt != null &&
        createdAt!.trim().isNotEmpty &&
        DateTime.tryParse(createdAt!) == null) {
      throw Exception('Invalid backup account creation timestamp');
    }

    if (updatedAt != null &&
        updatedAt!.trim().isNotEmpty &&
        DateTime.tryParse(updatedAt!) == null) {
      throw Exception('Invalid backup account update timestamp');
    }
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

  static DateTime? _readDateTime(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return DateTime.tryParse(value.trim());
  }
}
