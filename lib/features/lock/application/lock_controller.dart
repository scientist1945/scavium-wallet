import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/providers/service_providers.dart';
import 'package:scavium_wallet/features/wallet/data/wallet_repository_impl.dart';

final lockControllerProvider = AsyncNotifierProvider<LockController, bool>(
  LockController.new,
);

class LockController extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final repo = ref.read(walletRepositoryProvider);
    final profile = await repo.loadWalletProfile();
    return profile != null;
  }

  Future<bool> validatePin(String pin) async {
    final repo = ref.read(walletRepositoryProvider);
    return repo.validatePin(pin);
  }

  Future<bool> tryBiometricUnlock() async {
    final repo = ref.read(walletRepositoryProvider);
    final enabled = await repo.isBiometricEnabled();
    if (!enabled) return false;

    final bio = ref.read(biometricAuthProvider);
    return bio.authenticate();
  }
}
