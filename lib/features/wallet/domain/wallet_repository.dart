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

  Future<WalletProfile?> loadWalletProfile();
  Future<String?> readMnemonic();
  Future<String?> readPrivateKey();

  Future<void> savePin(String pin);
  Future<bool> validatePin(String pin);

  Future<void> enableBiometric(bool enabled);
  Future<bool> isBiometricEnabled();

  Future<void> clearWallet();

  EthPrivateKey credentialsFromMnemonic(String mnemonic);
}
