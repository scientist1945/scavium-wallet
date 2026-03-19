import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/services/local_storage_service.dart';

final localStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final onboardingControllerProvider =
    NotifierProvider<OnboardingController, bool>(OnboardingController.new);

class OnboardingController extends Notifier<bool> {
  @override
  bool build() => false;

  Future<void> completeOnboarding() async {
    final storage = ref.read(localStorageProvider);
    await storage.setBool(StorageKeys.onboardingCompleted, true);
    state = true;
  }
}
