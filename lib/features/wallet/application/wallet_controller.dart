import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/wallet/data/wallet_repository_impl.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_profile.dart';

final walletControllerProvider =
    AsyncNotifierProvider<WalletController, WalletProfile?>(
      WalletController.new,
    );

class WalletController extends AsyncNotifier<WalletProfile?> {
  @override
  Future<WalletProfile?> build() async {
    final repo = ref.read(walletRepositoryProvider);
    return repo.loadWalletProfile();
  }

  Future<String> generateMnemonicPreview() async {
    final repo = ref.read(walletRepositoryProvider);
    return repo.generateMnemonic();
  }

  Future<void> createWallet({
    required String accountName,
    required String pin,
    required bool biometricEnabled,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(walletRepositoryProvider);

    try {
      final profile = await repo.createWalletFromNewMnemonic(
        accountName: accountName,
      );
      await repo.savePin(pin);
      await repo.enableBiometric(biometricEnabled);
      state = AsyncData(profile.copyWith(biometricEnabled: biometricEnabled));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> importFromMnemonic({
    required String mnemonic,
    required String accountName,
    required String pin,
    required bool biometricEnabled,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(walletRepositoryProvider);

    try {
      final profile = await repo.importWalletFromMnemonic(
        mnemonic: mnemonic,
        accountName: accountName,
      );
      await repo.savePin(pin);
      await repo.enableBiometric(biometricEnabled);
      state = AsyncData(profile.copyWith(biometricEnabled: biometricEnabled));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> importFromPrivateKey({
    required String privateKey,
    required String accountName,
    required String pin,
    required bool biometricEnabled,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(walletRepositoryProvider);

    try {
      final profile = await repo.importWalletFromPrivateKey(
        privateKey: privateKey,
        accountName: accountName,
      );
      await repo.savePin(pin);
      await repo.enableBiometric(biometricEnabled);
      state = AsyncData(profile.copyWith(biometricEnabled: biometricEnabled));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<String?> readMnemonic() async {
    final repo = ref.read(walletRepositoryProvider);
    return repo.readMnemonic();
  }

  Future<void> resetWallet() async {
    state = const AsyncLoading();
    final repo = ref.read(walletRepositoryProvider);
    await repo.clearWallet();
    state = const AsyncData(null);
  }
}
