import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/services/backup_crypto_service.dart';
import 'package:scavium_wallet/core/services/backup_file_service.dart';
import 'package:scavium_wallet/features/wallet/data/wallet_repository_impl.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_backup_payload.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_repository.dart';

final backupCryptoServiceProvider = Provider<BackupCryptoService>((ref) {
  return BackupCryptoService();
});

final backupFileServiceProvider = Provider<BackupFileService>((ref) {
  return BackupFileService();
});

final walletBackupControllerProvider = Provider<WalletBackupController>((ref) {
  return WalletBackupController(
    walletRepository: ref.read(walletRepositoryProvider),
    backupCryptoService: ref.read(backupCryptoServiceProvider),
    backupFileService: ref.read(backupFileServiceProvider),
  );
});

class WalletBackupController {
  final WalletRepository walletRepository;
  final BackupCryptoService backupCryptoService;
  final BackupFileService backupFileService;

  WalletBackupController({
    required this.walletRepository,
    required this.backupCryptoService,
    required this.backupFileService,
  });

  Future<String> exportEncryptedBackup({required String password}) async {
    final profile = await walletRepository.loadWalletProfile();
    if (profile == null) {
      throw Exception('No wallet available to export');
    }

    final mnemonic = await walletRepository.readMnemonic();
    final privateKey = await walletRepository.readPrivateKey();

    final payload = WalletBackupPayload.v1(
      createdAt: DateTime.now(),
      wallet: WalletBackupWallet(
        type: profile.type.name,
        mnemonic: profile.type.name == 'mnemonic' ? mnemonic : null,
        privateKey: profile.type.name == 'privateKey' ? privateKey : null,
        address: profile.account.address,
        accountName: profile.account.name,
      ),
    );

    final encrypted = await backupCryptoService.encryptPayload(
      payload: payload,
      password: password,
    );

    return backupFileService.encodeBackup(encrypted);
  }

  Future<WalletBackupPayload> decodeAndDecryptBackup({
    required String rawBackup,
    required String password,
  }) async {
    final encrypted = backupFileService.decodeBackup(rawBackup);
    return backupCryptoService.decryptPayload(
      encrypted: encrypted,
      password: password,
    );
  }

  Future<void> restoreEncryptedBackup({
    required String rawBackup,
    required String password,
  }) async {
    final payload = await decodeAndDecryptBackup(
      rawBackup: rawBackup,
      password: password,
    );

    if (payload.wallet.type == 'mnemonic') {
      final mnemonic = payload.wallet.mnemonic;
      if (mnemonic == null || mnemonic.trim().isEmpty) {
        throw Exception('Backup mnemonic is missing');
      }

      await walletRepository.importWalletFromMnemonic(
        mnemonic: mnemonic,
        accountName: payload.wallet.accountName,
      );
      return;
    }

    if (payload.wallet.type == 'privateKey') {
      final privateKey = payload.wallet.privateKey;
      if (privateKey == null || privateKey.trim().isEmpty) {
        throw Exception('Backup private key is missing');
      }

      await walletRepository.importWalletFromPrivateKey(
        privateKey: privateKey,
        accountName: payload.wallet.accountName,
      );
      return;
    }

    throw Exception('Unsupported backup wallet type');
  }

  String buildDefaultBackupFileName({
    required String address,
    required String network,
  }) {
    return backupFileService.buildDefaultFileName(
      address: address,
      network: network,
    );
  }
}
