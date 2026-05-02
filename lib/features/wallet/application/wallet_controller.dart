import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/wallet/data/wallet_repository_impl.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_account.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_profile.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_repository.dart';

final walletControllerProvider =
    AsyncNotifierProvider<WalletController, WalletProfile?>(
      WalletController.new,
    );

class WalletController extends AsyncNotifier<WalletProfile?> {
  WalletRepository get _repository => ref.read(walletRepositoryProvider);

  WalletAccount? get activeAccount => state.valueOrNull?.activeAccount;

  @override
  Future<WalletProfile?> build() {
    return _repository.loadWalletProfile();
  }

  Future<String> generateMnemonic() {
    return _repository.generateMnemonic();
  }

  Future<bool> validateMnemonic(String mnemonic) {
    return _repository.validateMnemonic(mnemonic);
  }

  Future<String?> readMnemonic() {
    return _repository.readMnemonic();
  }

  Future<WalletProfile> createWalletFromNewMnemonic({
    required String accountName,
  }) async {
    state = const AsyncLoading();

    final profile = await AsyncValue.guard(
      () => _repository.createWalletFromNewMnemonic(accountName: accountName),
    );

    state = profile;
    return profile.requireValue;
  }

  Future<WalletProfile> importWalletFromMnemonic({
    required String mnemonic,
    required String accountName,
  }) async {
    state = const AsyncLoading();

    final profile = await AsyncValue.guard(
      () => _repository.importWalletFromMnemonic(
        mnemonic: mnemonic,
        accountName: accountName,
      ),
    );

    state = profile;
    return profile.requireValue;
  }

  Future<WalletProfile> importWalletFromPrivateKey({
    required String privateKey,
    required String accountName,
  }) async {
    state = const AsyncLoading();

    final profile = await AsyncValue.guard(
      () => _repository.importWalletFromPrivateKey(
        privateKey: privateKey,
        accountName: accountName,
      ),
    );

    state = profile;
    return profile.requireValue;
  }

  Future<WalletProfile> createWallet({
    required String accountName,
    required String pin,
    required bool biometricEnabled,
  }) async {
    state = const AsyncLoading();

    final profile = await AsyncValue.guard(() async {
      final created = await _repository.createWalletFromNewMnemonic(
        accountName: accountName,
      );
      await _repository.savePin(pin);
      await _repository.enableBiometric(biometricEnabled);
      return created;
    });

    state = profile;
    return profile.requireValue;
  }

  Future<WalletProfile> importFromMnemonic({
    required String mnemonic,
    required String accountName,
    required String pin,
    required bool biometricEnabled,
  }) async {
    state = const AsyncLoading();

    final profile = await AsyncValue.guard(() async {
      final imported = await _repository.importWalletFromMnemonic(
        mnemonic: mnemonic,
        accountName: accountName,
      );
      await _repository.savePin(pin);
      await _repository.enableBiometric(biometricEnabled);
      return imported;
    });

    state = profile;
    return profile.requireValue;
  }

  Future<WalletProfile> importFromPrivateKey({
    required String privateKey,
    required String accountName,
    required String pin,
    required bool biometricEnabled,
  }) async {
    state = const AsyncLoading();

    final profile = await AsyncValue.guard(() async {
      final imported = await _repository.importWalletFromPrivateKey(
        privateKey: privateKey,
        accountName: accountName,
      );
      await _repository.savePin(pin);
      await _repository.enableBiometric(biometricEnabled);
      return imported;
    });

    state = profile;
    return profile.requireValue;
  }

  Future<WalletProfile> setActiveAccount(String accountId) async {
    final previous = state;
    state = const AsyncLoading();

    final profile = await AsyncValue.guard(
      () => _repository.setActiveAccount(accountId),
    );

    state = profile.hasError ? previous : profile;
    return profile.requireValue;
  }

  Future<WalletProfile> addDerivedAccount({required String accountName}) async {
    final previous = state;
    state = const AsyncLoading();

    final profile = await AsyncValue.guard(
      () => _repository.addDerivedAccount(accountName: accountName),
    );

    state = profile.hasError ? previous : profile;
    return profile.requireValue;
  }

  Future<WalletProfile> addPrivateKeyAccount({
    required String privateKey,
    required String accountName,
  }) async {
    final previous = state;
    state = const AsyncLoading();

    final profile = await AsyncValue.guard(
      () => _repository.addPrivateKeyAccount(
        privateKey: privateKey,
        accountName: accountName,
      ),
    );

    state = profile.hasError ? previous : profile;
    return profile.requireValue;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_repository.loadWalletProfile);
  }

  Future<void> resetWallet() async {
    await _repository.clearWallet();
    state = const AsyncData(null);
  }
}
