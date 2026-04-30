import 'package:scavium_wallet/features/wallet/domain/wallet_backup_payload.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_profile.dart';
import 'package:web3dart/web3dart.dart';

abstract class WalletRepository {
  Future<String> generateMnemonic();
  Future<bool> validateMnemonic(String mnemonic);

  Future<WalletProfile> createWalletFromNewMnemonic({
    required String accountName,
  });

  Future<WalletProfile> importWalletFromMnemonic({
    required String mnemonic,
    required String accountName,
  });

  Future<WalletProfile> importWalletFromPrivateKey({
    required String privateKey,
    required String accountName,
  });

  Future<WalletProfile> restoreWalletBackup(WalletBackupPayload payload);

  Future<WalletProfile?> loadWalletProfile();
  Future<WalletProfile> setActiveAccount(String accountId);

  Future<WalletProfile> addDerivedAccount({required String accountName});

  Future<WalletProfile> addPrivateKeyAccount({
    required String privateKey,
    required String accountName,
  });
  Future<String?> readMnemonic();
  Future<String?> readPrivateKey();

  Future<void> savePin(String pin);
  Future<bool> validatePin(String pin);

  Future<void> enableBiometric(bool enabled);
  Future<bool> isBiometricEnabled();

  Future<void> clearWallet();

  EthPrivateKey credentialsFromMnemonic(String mnemonic);
}
