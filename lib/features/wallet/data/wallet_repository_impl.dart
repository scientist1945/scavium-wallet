import 'dart:convert';

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
import 'package:scavium_wallet/features/wallet/domain/wallet_backup_payload.dart';
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

  static String _derivationPathForIndex(int accountIndex) =>
      "m/44'/60'/0'/0/$accountIndex";
  static const _walletStorageVersion = '2';

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
    final address = credentials.address;

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
      await secureStorage.delete(StorageKeys.walletImportedPrivateKeysJson);

      final account = _buildSingleAccount(
        accountName: accountName,
        address: address.hexEip55,
        isImportedByPrivateKey: false,
      );
      await _persistMultiAccountMetadata(
        accounts: <WalletAccount>[account],
        activeAccountId: account.id,
        defaultAccountId: account.id,
      );

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

      return _buildSingleAccountProfile(
        type: ImportedWalletType.mnemonic,
        accountName: accountName,
        address: address.hexEip55,
        hasMnemonic: true,
        isImportedByPrivateKey: false,
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
    final address = credentials.address;

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
      await secureStorage.delete(StorageKeys.walletImportedPrivateKeysJson);

      final account = _buildSingleAccount(
        accountName: accountName,
        address: address.hexEip55,
        isImportedByPrivateKey: true,
      );
      await _persistImportedPrivateKeyForAccount(
        accountId: account.id,
        privateKey: normalized,
      );
      await _persistMultiAccountMetadata(
        accounts: <WalletAccount>[account],
        activeAccountId: account.id,
        defaultAccountId: account.id,
      );

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

      return _buildSingleAccountProfile(
        type: ImportedWalletType.privateKey,
        accountName: accountName,
        address: address.hexEip55,
        hasMnemonic: false,
        isImportedByPrivateKey: true,
      );
    } catch (_) {
      await _clearWalletAvailabilityFlags();
      rethrow;
    }
  }

  @override
  Future<WalletProfile> restoreWalletBackup(WalletBackupPayload payload) async {
    payload.validate();

    late final WalletProfile restoredProfile;

    if (payload.wallet.type == ImportedWalletType.mnemonic.name) {
      final mnemonic = payload.wallet.mnemonic;
      if (mnemonic == null || mnemonic.trim().isEmpty) {
        throw Exception('Backup mnemonic is missing');
      }

      restoredProfile = await importWalletFromMnemonic(
        mnemonic: mnemonic,
        accountName: payload.wallet.accountName,
      );
    } else if (payload.wallet.type == ImportedWalletType.privateKey.name) {
      final privateKey = payload.wallet.privateKey;
      if (privateKey == null || privateKey.trim().isEmpty) {
        throw Exception('Backup private key is missing');
      }

      restoredProfile = await importWalletFromPrivateKey(
        privateKey: privateKey,
        accountName: payload.wallet.accountName,
      );
    } else {
      throw Exception('Unsupported backup wallet type');
    }

    if (payload.version < 2 || payload.accounts.isEmpty) {
      return restoredProfile;
    }

    final restoredAccounts = payload.accounts
        .map((account) => account.toWalletAccount())
        .toList(growable: false);
    final defaultAccountId = _resolveStoredAccountId(
      accounts: restoredAccounts,
      preferredAccountId: payload.defaultAccountId,
      fallbackAccountId: restoredProfile.defaultAccountId,
    );
    final activeAccountId = _resolveStoredAccountId(
      accounts: restoredAccounts,
      preferredAccountId: payload.activeAccountId,
      fallbackAccountId: defaultAccountId,
    );
    final activeAccount = _resolveAccountById(
      accounts: restoredAccounts,
      accountId: activeAccountId,
    );
    final normalizedAccounts = _normalizeStoredAccountFlags(
      accounts: restoredAccounts,
      activeAccountId: activeAccountId,
      defaultAccountId: defaultAccountId,
    );

    for (final account in payload.accounts) {
      if (account.isImportedByPrivateKey &&
          account.privateKey != null &&
          account.privateKey!.trim().isNotEmpty) {
        await _persistImportedPrivateKeyForAccount(
          accountId: account.id,
          privateKey: _normalizePrivateKey(account.privateKey!),
        );
      }
    }

    await _persistMultiAccountMetadata(
      accounts: normalizedAccounts,
      activeAccountId: activeAccountId,
      defaultAccountId: defaultAccountId,
    );

    return restoredProfile.copyWith(
      account: activeAccount.copyWith(isActive: true),
      accounts: normalizedAccounts,
      activeAccountId: activeAccountId,
      defaultAccountId: defaultAccountId,
    );
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

      return _buildSingleAccountProfile(
        type: type,
        accountName: accountName,
        address: address,
        hasMnemonic: true,
        isImportedByPrivateKey: false,
      );
    }

    final privateKey = await secureStorage.read(StorageKeys.walletPrivateKey);
    if (privateKey == null || privateKey.isEmpty) {
      await _clearWalletAvailabilityFlags();
      return null;
    }

    return _buildSingleAccountProfile(
      type: type,
      accountName: accountName,
      address: address,
      hasMnemonic: false,
      isImportedByPrivateKey: true,
    );
  }

  Future<WalletProfile> _buildSingleAccountProfile({
    required ImportedWalletType type,
    required String accountName,
    required String address,
    required bool hasMnemonic,
    required bool isImportedByPrivateKey,
  }) async {
    final legacyAccount = _buildSingleAccount(
      accountName: accountName,
      address: address,
      isImportedByPrivateKey: isImportedByPrivateKey,
    );
    final storedAccountState = await _loadOrCreateStoredAccountState(
      legacyAccount,
    );
    final activeAccount = _resolveAccountById(
      accounts: storedAccountState.accounts,
      accountId: storedAccountState.activeAccountId,
    );

    return WalletProfile(
      type: type,
      account: activeAccount,
      accounts: storedAccountState.accounts,
      activeAccountId: activeAccount.id,
      defaultAccountId: storedAccountState.defaultAccountId,
      hasMnemonic: hasMnemonic,
      biometricEnabled: await isBiometricEnabled(),
    );
  }

  WalletAccount _buildSingleAccount({
    required String accountName,
    required String address,
    required bool isImportedByPrivateKey,
  }) {
    return WalletAccount(
      name: accountName,
      address: address,
      accountIndex: 0,
      isImportedByPrivateKey: isImportedByPrivateKey,
      isDefault: true,
      isActive: true,
    );
  }

  Future<_StoredAccountState> _loadOrCreateStoredAccountState(
    WalletAccount legacyAccount,
  ) async {
    final storedAccounts = await _readStoredAccounts();
    final activeAccountId = await secureStorage.read(
      StorageKeys.walletActiveAccountId,
    );
    final defaultAccountId = await secureStorage.read(
      StorageKeys.walletDefaultAccountId,
    );

    if (storedAccounts.isEmpty) {
      await _persistMultiAccountMetadata(
        accounts: <WalletAccount>[legacyAccount],
        activeAccountId: legacyAccount.id,
        defaultAccountId: legacyAccount.id,
      );

      return _StoredAccountState(
        accounts: <WalletAccount>[legacyAccount],
        activeAccountId: legacyAccount.id,
        defaultAccountId: legacyAccount.id,
      );
    }

    final resolvedDefaultAccountId = _resolveStoredAccountId(
      accounts: storedAccounts,
      preferredAccountId: defaultAccountId,
      fallbackAccountId: legacyAccount.id,
    );
    final resolvedActiveAccountId = _resolveStoredAccountId(
      accounts: storedAccounts,
      preferredAccountId: activeAccountId,
      fallbackAccountId: resolvedDefaultAccountId,
    );
    final normalizedAccounts = _normalizeStoredAccountFlags(
      accounts: storedAccounts,
      activeAccountId: resolvedActiveAccountId,
      defaultAccountId: resolvedDefaultAccountId,
    );

    await _persistMultiAccountMetadata(
      accounts: normalizedAccounts,
      activeAccountId: resolvedActiveAccountId,
      defaultAccountId: resolvedDefaultAccountId,
    );

    return _StoredAccountState(
      accounts: normalizedAccounts,
      activeAccountId: resolvedActiveAccountId,
      defaultAccountId: resolvedDefaultAccountId,
    );
  }

  Future<List<WalletAccount>> _readStoredAccounts() async {
    final rawAccounts = await secureStorage.read(
      StorageKeys.walletAccountsJson,
    );

    if (rawAccounts == null || rawAccounts.trim().isEmpty) {
      return <WalletAccount>[];
    }

    try {
      final decoded = jsonDecode(rawAccounts);
      if (decoded is! List) {
        return <WalletAccount>[];
      }

      return decoded
          .whereType<Map<String, dynamic>>()
          .map(WalletAccount.fromJson)
          .where((account) => account.address.trim().isNotEmpty)
          .toList(growable: false);
    } catch (_) {
      return <WalletAccount>[];
    }
  }

  Future<void> _persistMultiAccountMetadata({
    required List<WalletAccount> accounts,
    required String activeAccountId,
    required String defaultAccountId,
  }) async {
    final normalizedAccounts = _normalizeStoredAccountFlags(
      accounts: accounts,
      activeAccountId: activeAccountId,
      defaultAccountId: defaultAccountId,
    );
    final encodedAccounts = jsonEncode(
      normalizedAccounts.map((account) => account.toJson()).toList(),
    );

    await secureStorage.writeAndVerify(
      StorageKeys.walletAccountsJson,
      encodedAccounts,
    );
    await secureStorage.writeAndVerify(
      StorageKeys.walletActiveAccountId,
      activeAccountId,
    );
    await secureStorage.writeAndVerify(
      StorageKeys.walletDefaultAccountId,
      defaultAccountId,
    );
    await secureStorage.writeAndVerify(
      StorageKeys.walletStorageVersion,
      _walletStorageVersion,
    );
  }

  List<WalletAccount> _normalizeStoredAccountFlags({
    required List<WalletAccount> accounts,
    required String activeAccountId,
    required String defaultAccountId,
  }) {
    return accounts
        .map(
          (account) => account.copyWith(
            isActive: account.id == activeAccountId,
            isDefault: account.id == defaultAccountId,
          ),
        )
        .toList(growable: false);
  }

  String _resolveStoredAccountId({
    required List<WalletAccount> accounts,
    required String? preferredAccountId,
    required String fallbackAccountId,
  }) {
    if (preferredAccountId != null &&
        accounts.any((account) => account.id == preferredAccountId)) {
      return preferredAccountId;
    }
    if (accounts.any((account) => account.id == fallbackAccountId)) {
      return fallbackAccountId;
    }
    return accounts.first.id;
  }

  WalletAccount _resolveAccountById({
    required List<WalletAccount> accounts,
    required String accountId,
  }) {
    return accounts.firstWhere(
      (account) => account.id == accountId,
      orElse: () => accounts.first,
    );
  }

  WalletAccount _resolveRequiredAccountById({
    required List<WalletAccount> accounts,
    required String accountId,
  }) {
    return accounts.firstWhere(
      (account) => account.id == accountId,
      orElse: () => throw StateError('Wallet account not found'),
    );
  }

  @override
  Future<WalletProfile> setActiveAccount(String accountId) async {
    final profile = await loadWalletProfile();
    if (profile == null) {
      throw StateError('No wallet profile is loaded');
    }

    final requestedAccount = _resolveRequiredAccountById(
      accounts: profile.accounts,
      accountId: accountId,
    );
    final normalizedAccounts = _normalizeStoredAccountFlags(
      accounts: profile.accounts,
      activeAccountId: requestedAccount.id,
      defaultAccountId: profile.defaultAccountId,
    );

    await _persistMultiAccountMetadata(
      accounts: normalizedAccounts,
      activeAccountId: requestedAccount.id,
      defaultAccountId: profile.defaultAccountId,
    );

    return profile.copyWith(
      account: requestedAccount.copyWith(isActive: true),
      accounts: normalizedAccounts,
      activeAccountId: requestedAccount.id,
    );
  }

  @override
  Future<WalletProfile> addDerivedAccount({required String accountName}) async {
    final profile = await loadWalletProfile();
    if (profile == null) {
      throw StateError('No wallet profile is loaded');
    }

    final mnemonic = await secureStorage.read(StorageKeys.walletMnemonic);
    if (mnemonic == null || mnemonic.trim().isEmpty) {
      throw StateError('Derived accounts require a mnemonic wallet');
    }

    final accountIndex = _nextAccountIndex(profile.accounts);
    final credentials = _credentialsFromMnemonicAtIndex(mnemonic, accountIndex);
    final address = credentials.address;

    _ensureUniqueAccountAddress(
      accounts: profile.accounts,
      address: address.hexEip55,
    );

    final now = DateTime.now().toUtc();
    final account = WalletAccount(
      name: _normalizeAccountName(accountName, accountIndex),
      address: address.hexEip55,
      accountIndex: accountIndex,
      isImportedByPrivateKey: false,
      createdAt: now,
      updatedAt: now,
    );

    return _appendAndActivateAccount(profile: profile, account: account);
  }

  @override
  Future<WalletProfile> addPrivateKeyAccount({
    required String privateKey,
    required String accountName,
  }) async {
    final profile = await loadWalletProfile();
    if (profile == null) {
      throw StateError('No wallet profile is loaded');
    }

    final normalizedPrivateKey = _normalizePrivateKey(privateKey);
    if (!_isValidPrivateKey(normalizedPrivateKey)) {
      throw Exception('Private key inválida');
    }

    final credentials = EthPrivateKey.fromHex(normalizedPrivateKey);
    final address = credentials.address;

    _ensureUniqueAccountAddress(
      accounts: profile.accounts,
      address: address.hexEip55,
    );

    final accountIndex = _nextAccountIndex(profile.accounts);
    final now = DateTime.now().toUtc();
    final account = WalletAccount(
      name: _normalizeAccountName(accountName, accountIndex),
      address: address.hexEip55,
      accountIndex: accountIndex,
      isImportedByPrivateKey: true,
      createdAt: now,
      updatedAt: now,
    );

    await _persistImportedPrivateKeyForAccount(
      accountId: account.id,
      privateKey: normalizedPrivateKey,
    );

    return _appendAndActivateAccount(profile: profile, account: account);
  }

  Future<WalletProfile> _appendAndActivateAccount({
    required WalletProfile profile,
    required WalletAccount account,
  }) async {
    final accounts = <WalletAccount>[...profile.accounts, account];
    final normalizedAccounts = _normalizeStoredAccountFlags(
      accounts: accounts,
      activeAccountId: account.id,
      defaultAccountId: profile.defaultAccountId,
    );

    await _persistMultiAccountMetadata(
      accounts: normalizedAccounts,
      activeAccountId: account.id,
      defaultAccountId: profile.defaultAccountId,
    );

    return profile.copyWith(
      account: account.copyWith(isActive: true),
      accounts: normalizedAccounts,
      activeAccountId: account.id,
    );
  }

  int _nextAccountIndex(List<WalletAccount> accounts) {
    if (accounts.isEmpty) {
      return 0;
    }

    final highestIndex = accounts
        .map((account) => account.accountIndex)
        .reduce((value, element) => value > element ? value : element);
    return highestIndex + 1;
  }

  String _normalizeAccountName(String accountName, int accountIndex) {
    final normalized = accountName.trim();
    if (normalized.isNotEmpty) {
      return normalized;
    }
    return 'Account ${accountIndex + 1}';
  }

  void _ensureUniqueAccountAddress({
    required List<WalletAccount> accounts,
    required String address,
  }) {
    final normalizedAddress = address.trim().toLowerCase();
    final alreadyExists = accounts.any(
      (account) => account.address.trim().toLowerCase() == normalizedAddress,
    );

    if (alreadyExists) {
      throw StateError('Account already exists in this wallet');
    }
  }

  @override
  Future<Map<String, String>> readImportedPrivateKeys() async {
    final raw = await secureStorage.read(
      StorageKeys.walletImportedPrivateKeysJson,
    );

    if (raw == null || raw.trim().isEmpty) {
      return <String, String>{};
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return <String, String>{};
      }

      return decoded.map((key, value) => MapEntry(key, value?.toString() ?? ''))
        ..removeWhere(
          (key, value) => key.trim().isEmpty || value.trim().isEmpty,
        );
    } catch (_) {
      return <String, String>{};
    }
  }

  Future<void> _persistImportedPrivateKeyForAccount({
    required String accountId,
    required String privateKey,
  }) async {
    final importedPrivateKeys = await readImportedPrivateKeys();
    importedPrivateKeys[accountId] = privateKey;

    await secureStorage.writeAndVerify(
      StorageKeys.walletImportedPrivateKeysJson,
      jsonEncode(importedPrivateKeys),
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
    await secureStorage.delete(StorageKeys.walletAccountsJson);
    await secureStorage.delete(StorageKeys.walletActiveAccountId);
    await secureStorage.delete(StorageKeys.walletDefaultAccountId);
    await secureStorage.delete(StorageKeys.walletStorageVersion);
    await secureStorage.delete(StorageKeys.walletImportedPrivateKeysJson);
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
    return _credentialsFromMnemonicAtIndex(mnemonic, 0);
  }

  EthPrivateKey _credentialsFromMnemonicAtIndex(
    String mnemonic,
    int accountIndex,
  ) {
    final seed = bip39.mnemonicToSeed(_normalizeMnemonic(mnemonic));
    final root = bip32.BIP32.fromSeed(seed);
    final child = root.derivePath(_derivationPathForIndex(accountIndex));

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

class _StoredAccountState {
  final List<WalletAccount> accounts;
  final String activeAccountId;
  final String defaultAccountId;

  const _StoredAccountState({
    required this.accounts,
    required this.activeAccountId,
    required this.defaultAccountId,
  });
}
