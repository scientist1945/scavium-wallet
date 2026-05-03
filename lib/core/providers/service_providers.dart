import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/app/theme/theme_mode_repository.dart';
import 'package:scavium_wallet/app/theme/theme_mode_repository_impl.dart';
import 'package:scavium_wallet/core/services/biometric_auth_service.dart';
import 'package:scavium_wallet/core/services/local_storage_service.dart';
import 'package:scavium_wallet/core/services/secure_storage_service.dart';

final localStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final themeModeRepositoryProvider = Provider<ThemeModeRepository>((ref) {
  return LocalThemeModeRepository(ref.watch(localStorageProvider));
});

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final biometricAuthProvider = Provider<BiometricAuthService>((ref) {
  return BiometricAuthService();
});
