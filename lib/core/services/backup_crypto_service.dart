import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:scavium_wallet/features/wallet/domain/encrypted_wallet_backup.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_backup_payload.dart';

class BackupCryptoService {
  static const int _kdfIterations = 100000;
  static const int _saltLength = 16;
  static const int _nonceLength = 12;
  static const int _aesKeyLength = 32;

  final Cryptography _cryptography;

  BackupCryptoService({Cryptography? cryptography})
    : _cryptography = cryptography ?? FlutterCryptography.defaultInstance;

  Future<EncryptedWalletBackup> encryptPayload({
    required WalletBackupPayload payload,
    required String password,
  }) async {
    _validatePassword(password);
    payload.validate();

    final salt = _randomBytes(_saltLength);
    final nonce = _randomBytes(_nonceLength);
    final secretKey = await _deriveKey(password: password, salt: salt);

    final plaintext = utf8.encode(jsonEncode(payload.toJson()));

    final algorithm = AesGcm.with256bits();
    final secretBox = await algorithm.encrypt(
      plaintext,
      secretKey: secretKey,
      nonce: nonce,
    );

    return EncryptedWalletBackup(
      format: 'scavium_wallet_encrypted_backup',
      version: 1,
      kdf: BackupKdfConfig(
        name: 'pbkdf2',
        iterations: _kdfIterations,
        saltBase64: base64Encode(salt),
      ),
      cipher: BackupCipherConfig(
        name: 'aes-gcm',
        nonceBase64: base64Encode(secretBox.nonce),
        ciphertextBase64: base64Encode(secretBox.cipherText),
        macBase64: base64Encode(secretBox.mac.bytes),
      ),
    );
  }

  Future<WalletBackupPayload> decryptPayload({
    required EncryptedWalletBackup encrypted,
    required String password,
  }) async {
    _validatePassword(password);
    encrypted.validate();

    final salt = base64Decode(encrypted.kdf.saltBase64);
    final nonce = base64Decode(encrypted.cipher.nonceBase64);
    final cipherText = base64Decode(encrypted.cipher.ciphertextBase64);
    final macBytes = base64Decode(encrypted.cipher.macBase64);

    final secretKey = await _deriveKey(password: password, salt: salt);

    final algorithm = AesGcm.with256bits();

    final clearBytes = await algorithm.decrypt(
      SecretBox(cipherText, nonce: nonce, mac: Mac(macBytes)),
      secretKey: secretKey,
    );

    final decoded = jsonDecode(utf8.decode(clearBytes));
    final payload = WalletBackupPayload.fromJson(
      Map<String, dynamic>.from(decoded as Map),
    );

    payload.validate();
    return payload;
  }

  Future<SecretKey> _deriveKey({
    required String password,
    required List<int> salt,
  }) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: _kdfIterations,
      bits: _aesKeyLength * 8,
    );

    return pbkdf2.deriveKeyFromPassword(password: password, nonce: salt);
  }

  List<int> _randomBytes(int length) {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(length, (_) => random.nextInt(256)),
    );
  }

  void _validatePassword(String password) {
    if (password.trim().isEmpty) {
      throw Exception('Backup password cannot be empty');
    }

    if (password.length < 8) {
      throw Exception('Backup password must be at least 8 characters');
    }
  }
}
