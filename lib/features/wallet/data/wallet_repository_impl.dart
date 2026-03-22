import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hex/hex.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/providers/service_providers.dart';
import 'package:scavium_wallet/core/services/local_storage_service.dart';
import 'package:scavium_wallet/core/services/secure_storage_service.dart';
import 'package:scavium_wallet/features/wallet/domain/imported_wallet_type.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_account.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_profile.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_repository.dart';
import 'package:web3dart/web3dart.dart';

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepositoryImpl(
    secureStorage: ref.read(secureStorageProvider),
    localStorage: ref.read(localStorageProvider),
  );
});

class WalletRepositoryImpl implements WalletRepository {
  final SecureStorageService secureStorage;
  final LocalStorageService localStorage;

  WalletRepositoryImpl({
    required this.secureStorage,
    required this.localStorage,
  });

  static const _derivationPath = "m/44'/60'/0'/0/0";

  @override
  Future<String> generateMnemonic() async {
    return bip39.generateMnemonic();
  }

  @override
  Future<bool> validateMnemonic(String mnemonic) async {
    return bip39.validateMnemonic(_normalizeMnemonic(mnemonic));
  }

  @override
  Future<WalletProfile> createWalletFromNewMnemonic({
    required String accountName,
  }) async {
    final mnemonic = bip39.generateMnemonic();
    return importWalletFromMnemonic(
      mnemonic: mnemonic,
      accountName: accountName,
    );
  }

  @override
  Future<WalletProfile> importWalletFromMnemonic({
    required String mnemonic,
    required String accountName,
  }) async {
    final normalized = _normalizeMnemonic(mnemonic);

    if (!bip39.validateMnemonic(normalized)) {
      throw Exception('Mnemonic inválida');
    }

    final credentials = _credentialsFromMnemonic(normalized);
    final address = await credentials.extractAddress();

    try {
      await secureStorage.writeAndVerify(
        StorageKeys.walletMnemonic,
        normalized,
      );
      await secureStorage.writeAndVerify(
        StorageKeys.walletType,
        ImportedWalletType.mnemonic.name,
      );
      await secureStorage.writeAndVerify(
        StorageKeys.walletAddress,
        address.hexEip55,
      );
      await secureStorage.writeAndVerify(
        StorageKeys.walletAccountName,
        accountName,
      );

      await secureStorage.delete(StorageKeys.walletPrivateKey);

      await _setWalletCreated(true);

      final persistedMnemonic = await secureStorage.read(
        StorageKeys.walletMnemonic,
      );
      final persistedType = await secureStorage.read(StorageKeys.walletType);
      final persistedAddress = await secureStorage.read(
        StorageKeys.walletAddress,
      );
      final persistedAccountName = await secureStorage.read(
        StorageKeys.walletAccountName,
      );

      if (persistedMnemonic == null ||
          persistedMnemonic.isEmpty ||
          persistedType != ImportedWalletType.mnemonic.name ||
          persistedAddress != address.hexEip55 ||
          persistedAccountName != accountName) {
        throw Exception('No se pudo persistir la wallet creada desde mnemonic');
      }

      return WalletProfile(
        type: ImportedWalletType.mnemonic,
        hasMnemonic: true,
        biometricEnabled: await isBiometricEnabled(),
        account: WalletAccount(
          name: accountName,
          address: address.hexEip55,
          accountIndex: 0,
          isImportedByPrivateKey: false,
        ),
      );
    } catch (_) {
      await _clearWalletAvailabilityFlags();
      rethrow;
    }
  }

  @override
  Future<WalletProfile> importWalletFromPrivateKey({
    required String privateKey,
    required String accountName,
  }) async {
    final normalized = _normalizePrivateKey(privateKey);

    if (!_isValidPrivateKey(normalized)) {
      throw Exception('Private key inválida');
    }

    final credentials = EthPrivateKey.fromHex(normalized);
    final address = await credentials.extractAddress();

    try {
      await secureStorage.writeAndVerify(
        StorageKeys.walletPrivateKey,
        normalized,
      );
      await secureStorage.writeAndVerify(
        StorageKeys.walletType,
        ImportedWalletType.privateKey.name,
      );
      await secureStorage.writeAndVerify(
        StorageKeys.walletAddress,
        address.hexEip55,
      );
      await secureStorage.writeAndVerify(
        StorageKeys.walletAccountName,
        accountName,
      );

      await secureStorage.delete(StorageKeys.walletMnemonic);

      await _setWalletCreated(true);

      final persistedPrivateKey = await secureStorage.read(
        StorageKeys.walletPrivateKey,
      );
      final persistedType = await secureStorage.read(StorageKeys.walletType);
      final persistedAddress = await secureStorage.read(
        StorageKeys.walletAddress,
      );
      final persistedAccountName = await secureStorage.read(
        StorageKeys.walletAccountName,
      );

      if (persistedPrivateKey == null ||
          persistedPrivateKey.isEmpty ||
          persistedType != ImportedWalletType.privateKey.name ||
          persistedAddress != address.hexEip55 ||
          persistedAccountName != accountName) {
        throw Exception(
          'No se pudo persistir la wallet importada desde private key',
        );
      }

      return WalletProfile(
        type: ImportedWalletType.privateKey,
        hasMnemonic: false,
        biometricEnabled: await isBiometricEnabled(),
        account: WalletAccount(
          name: accountName,
          address: address.hexEip55,
          accountIndex: 0,
          isImportedByPrivateKey: true,
        ),
      );
    } catch (_) {
      await _clearWalletAvailabilityFlags();
      rethrow;
    }
  }

  @override
  Future<WalletProfile?> loadWalletProfile() async {
    final walletType = await secureStorage.read(StorageKeys.walletType);
    final address = await secureStorage.read(StorageKeys.walletAddress);
    final accountName = await secureStorage.read(StorageKeys.walletAccountName);

    if (walletType == null || address == null || accountName == null) {
      await _clearWalletAvailabilityFlags();
      return null;
    }

    final type = ImportedWalletType.values.firstWhere(
      (e) => e.name == walletType,
      orElse: () => ImportedWalletType.mnemonic,
    );

    if (type == ImportedWalletType.mnemonic) {
      final mnemonic = await secureStorage.read(StorageKeys.walletMnemonic);

      if (mnemonic == null || mnemonic.isEmpty) {
        await _clearWalletAvailabilityFlags();
        return null;
      }

      return WalletProfile(
        type: type,
        hasMnemonic: true,
        biometricEnabled: await isBiometricEnabled(),
        account: WalletAccount(
          name: accountName,
          address: address,
          accountIndex: 0,
          isImportedByPrivateKey: false,
        ),
      );
    }

    final privateKey = await secureStorage.read(StorageKeys.walletPrivateKey);
    if (privateKey == null || privateKey.isEmpty) {
      await _clearWalletAvailabilityFlags();
      return null;
    }

    return WalletProfile(
      type: type,
      hasMnemonic: false,
      biometricEnabled: await isBiometricEnabled(),
      account: WalletAccount(
        name: accountName,
        address: address,
        accountIndex: 0,
        isImportedByPrivateKey: true,
      ),
    );
  }

  @override
  Future<String?> readMnemonic() {
    return secureStorage.read(StorageKeys.walletMnemonic);
  }

  @override
  Future<String?> readPrivateKey() {
    return secureStorage.read(StorageKeys.walletPrivateKey);
  }

  @override
  Future<void> savePin(String pin) async {
    await secureStorage.writeAndVerify(StorageKeys.appPin, pin);
    await localStorage.setBool(StorageKeys.lockEnabled, true);

    final enabled = await localStorage.getBool(StorageKeys.lockEnabled);
    if (!enabled) {
      throw Exception('No se pudo persistir el lock PIN');
    }
  }

  @override
  Future<bool> validatePin(String pin) async {
    final currentPin = await secureStorage.read(StorageKeys.appPin);
    return currentPin == pin;
  }

  @override
  Future<void> enableBiometric(bool enabled) async {
    await localStorage.setBool(StorageKeys.biometricEnabled, enabled);

    final persisted = await localStorage.getBool(
      StorageKeys.biometricEnabled,
      defaultValue: false,
    );

    if (persisted != enabled) {
      throw Exception('No se pudo persistir el estado de biometría');
    }
  }

  @override
  Future<bool> isBiometricEnabled() async {
    return localStorage.getBool(StorageKeys.biometricEnabled);
  }

  @override
  Future<void> clearWallet() async {
    await secureStorage.delete(StorageKeys.walletMnemonic);
    await secureStorage.delete(StorageKeys.walletPrivateKey);
    await secureStorage.delete(StorageKeys.walletType);
    await secureStorage.delete(StorageKeys.walletAddress);
    await secureStorage.delete(StorageKeys.walletAccountName);
    await secureStorage.delete(StorageKeys.appPin);

    await localStorage.setBool(StorageKeys.walletCreated, false);
    await localStorage.setBool(StorageKeys.biometricEnabled, false);
    await localStorage.setBool(StorageKeys.lockEnabled, false);
  }

  Future<void> _setWalletCreated(bool value) async {
    await localStorage.setBool(StorageKeys.walletCreated, value);
    final persisted = await localStorage.getBool(
      StorageKeys.walletCreated,
      defaultValue: false,
    );

    if (persisted != value) {
      throw Exception('No se pudo persistir el estado walletCreated');
    }
  }

  Future<void> _clearWalletAvailabilityFlags() async {
    await localStorage.setBool(StorageKeys.walletCreated, false);
    await localStorage.setBool(StorageKeys.biometricEnabled, false);
    await localStorage.setBool(StorageKeys.lockEnabled, false);
  }

  EthPrivateKey _credentialsFromMnemonic(String mnemonic) {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final root = bip32.BIP32.fromSeed(seed);
    final child = root.derivePath(_derivationPath);

    final privateKeyBytes = child.privateKey;
    if (privateKeyBytes == null) {
      throw Exception('No se pudo derivar private key desde mnemonic');
    }

    final privateKeyHex = HEX.encode(privateKeyBytes);
    return EthPrivateKey.fromHex(privateKeyHex);
  }

  bool _isValidPrivateKey(String value) {
    final hexRegex = RegExp(r'^[0-9a-fA-F]{64}$');
    return hexRegex.hasMatch(value);
  }

  String _normalizePrivateKey(String input) {
    var value = input.trim();
    if (value.startsWith('0x')) {
      value = value.substring(2);
    }
    return value;
  }

  String _normalizeMnemonic(String input) {
    return input
        .trim()
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .join(' ');
  }

  @override
  EthPrivateKey credentialsFromMnemonic(String mnemonic) {
    return _credentialsFromMnemonic(_normalizeMnemonic(mnemonic));
  }
}
