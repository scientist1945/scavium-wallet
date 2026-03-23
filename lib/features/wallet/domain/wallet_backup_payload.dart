class WalletBackupPayload {
  final String format;
  final int version;
  final String createdAt;
  final WalletBackupWallet wallet;

  const WalletBackupPayload({
    required this.format,
    required this.version,
    required this.createdAt,
    required this.wallet,
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

  Map<String, dynamic> toJson() {
    return {
      'format': format,
      'version': version,
      'created_at': createdAt,
      'wallet': wallet.toJson(),
    };
  }

  factory WalletBackupPayload.fromJson(Map<String, dynamic> json) {
    return WalletBackupPayload(
      format: json['format'] as String? ?? '',
      version: json['version'] as int? ?? 0,
      createdAt: json['created_at'] as String? ?? '',
      wallet: WalletBackupWallet.fromJson(
        Map<String, dynamic>.from(json['wallet'] as Map),
      ),
    );
  }

  void validate() {
    if (format != 'scavium_wallet_backup') {
      throw Exception('Invalid backup payload format');
    }

    if (version != 1) {
      throw Exception('Unsupported backup payload version');
    }

    if (createdAt.trim().isEmpty) {
      throw Exception('Invalid backup creation timestamp');
    }

    wallet.validate();
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
