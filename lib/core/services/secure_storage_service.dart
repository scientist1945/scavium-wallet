import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> write(String key, String value) {
    return _storage.write(key: key, value: value);
  }

  Future<void> writeAndVerify(String key, String value) async {
    await _storage.write(key: key, value: value);
    final persisted = await _storage.read(key: key);

    if (persisted != value) {
      throw Exception('Secure storage verification failed for key: $key');
    }
  }

  Future<String?> read(String key) {
    return _storage.read(key: key);
  }

  Future<void> delete(String key) {
    return _storage.delete(key: key);
  }

  Future<void> deleteAll() {
    return _storage.deleteAll();
  }
}
