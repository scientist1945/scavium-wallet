import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/constants/app_constants.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/services/secure_storage_service.dart';
import 'package:scavium_wallet/features/onboarding/application/onboarding_controller.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final lockControllerProvider = AsyncNotifierProvider<LockController, bool>(
  LockController.new,
);

class LockController extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final storage = ref.read(localStorageProvider);
    return storage.getBool(StorageKeys.lockEnabled);
  }

  Future<void> enableLock({String pin = AppConstants.defaultLockPin}) async {
    final storage = ref.read(localStorageProvider);
    final secureStorage = ref.read(secureStorageProvider);

    await storage.setBool(StorageKeys.lockEnabled, true);
    await secureStorage.write(StorageKeys.appPin, pin);

    state = const AsyncData(true);
  }

  Future<void> disableLock() async {
    final storage = ref.read(localStorageProvider);
    final secureStorage = ref.read(secureStorageProvider);

    await storage.setBool(StorageKeys.lockEnabled, false);
    await secureStorage.delete(StorageKeys.appPin);

    state = const AsyncData(false);
  }

  Future<bool> validatePin(String pin) async {
    final secureStorage = ref.read(secureStorageProvider);
    final currentPin = await secureStorage.read(StorageKeys.appPin);
    return currentPin == pin;
  }
}
