import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/providers/service_providers.dart';

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
