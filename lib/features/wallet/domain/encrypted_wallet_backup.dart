class EncryptedWalletBackup {
  final String format;
  final int version;
  final BackupKdfConfig kdf;
  final BackupCipherConfig cipher;

  const EncryptedWalletBackup({
    required this.format,
    required this.version,
    required this.kdf,
    required this.cipher,
  });

  Map<String, dynamic> toJson() {
    return {
      'format': format,
      'version': version,
      'kdf': kdf.toJson(),
      'cipher': cipher.toJson(),
    };
  }

  factory EncryptedWalletBackup.fromJson(Map<String, dynamic> json) {
    return EncryptedWalletBackup(
      format: json['format'] as String? ?? '',
      version: json['version'] as int? ?? 0,
      kdf: BackupKdfConfig.fromJson(
        Map<String, dynamic>.from(json['kdf'] as Map),
      ),
      cipher: BackupCipherConfig.fromJson(
        Map<String, dynamic>.from(json['cipher'] as Map),
      ),
    );
  }

  void validate() {
    if (format != 'scavium_wallet_encrypted_backup') {
      throw Exception('Invalid encrypted backup format');
    }

    if (version != 1) {
      throw Exception('Unsupported encrypted backup version');
    }

    kdf.validate();
    cipher.validate();
  }
}

class BackupKdfConfig {
  final String name;
  final int iterations;
  final String saltBase64;

  const BackupKdfConfig({
    required this.name,
    required this.iterations,
    required this.saltBase64,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'iterations': iterations, 'salt': saltBase64};
  }

  factory BackupKdfConfig.fromJson(Map<String, dynamic> json) {
    return BackupKdfConfig(
      name: json['name'] as String? ?? '',
      iterations: json['iterations'] as int? ?? 0,
      saltBase64: json['salt'] as String? ?? '',
    );
  }

  void validate() {
    if (name != 'pbkdf2') {
      throw Exception('Unsupported KDF');
    }
    if (iterations <= 0) {
      throw Exception('Invalid PBKDF2 iterations');
    }
    if (saltBase64.trim().isEmpty) {
      throw Exception('Missing PBKDF2 salt');
    }
  }
}

class BackupCipherConfig {
  final String name;
  final String nonceBase64;
  final String ciphertextBase64;
  final String macBase64;

  const BackupCipherConfig({
    required this.name,
    required this.nonceBase64,
    required this.ciphertextBase64,
    required this.macBase64,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nonce': nonceBase64,
      'ciphertext': ciphertextBase64,
      'mac': macBase64,
    };
  }

  factory BackupCipherConfig.fromJson(Map<String, dynamic> json) {
    return BackupCipherConfig(
      name: json['name'] as String? ?? '',
      nonceBase64: json['nonce'] as String? ?? '',
      ciphertextBase64: json['ciphertext'] as String? ?? '',
      macBase64: json['mac'] as String? ?? '',
    );
  }

  void validate() {
    if (name != 'aes-gcm') {
      throw Exception('Unsupported cipher');
    }
    if (nonceBase64.trim().isEmpty) {
      throw Exception('Missing nonce');
    }
    if (ciphertextBase64.trim().isEmpty) {
      throw Exception('Missing ciphertext');
    }
    if (macBase64.trim().isEmpty) {
      throw Exception('Missing MAC');
    }
  }
}
