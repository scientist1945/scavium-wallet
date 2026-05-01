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

String safeBackupExportErrorMessage([Object? error]) {
  return 'Backup export failed. Check wallet state and try again. No backup file was created.';
}

String safeBackupRestoreErrorMessage([Object? error]) {
  return 'Backup restore failed. Check that the backup file and password are correct.';
}

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
    try {
      final profile = await walletRepository.loadWalletProfile();
      if (profile == null) {
        throw Exception(
          'No wallet is available to export. Load a wallet before creating a backup.',
        );
      }

      final mnemonic = await walletRepository.readMnemonic();
      final privateKey = await walletRepository.readPrivateKey();
      final importedPrivateKeys =
          await walletRepository.readImportedPrivateKeys();

      final backupAccounts = profile.accounts
          .map((account) {
            final importedPrivateKey =
                account.isImportedByPrivateKey
                    ? importedPrivateKeys[account.id]
                    : null;

            return WalletBackupAccount.fromWalletAccount(
              account,
              privateKey: importedPrivateKey,
            );
          })
          .toList(growable: false);

      final payload = WalletBackupPayload.v2(
        createdAt: DateTime.now(),
        wallet: WalletBackupWallet(
          type: profile.type.name,
          mnemonic: profile.type.name == 'mnemonic' ? mnemonic : null,
          privateKey: profile.type.name == 'privateKey' ? privateKey : null,
          address: profile.activeAccount.address,
          accountName: profile.activeAccount.name,
        ),
        accounts: backupAccounts,
        activeAccountId: profile.activeAccountId,
        defaultAccountId: profile.defaultAccountId,
      );

      final encrypted = await backupCryptoService.encryptPayload(
        payload: payload,
        password: password,
      );

      return backupFileService.encodeBackup(encrypted);
    } catch (error) {
      throw Exception(safeBackupExportErrorMessage(error));
    }
  }

  Future<WalletBackupPayload> decodeAndDecryptBackup({
    required String rawBackup,
    required String password,
  }) async {
    try {
      final encrypted = backupFileService.decodeBackup(rawBackup);
      return backupCryptoService.decryptPayload(
        encrypted: encrypted,
        password: password,
      );
    } catch (error) {
      throw Exception(safeBackupRestoreErrorMessage(error));
    }
  }

  Future<void> restoreEncryptedBackup({
    required String rawBackup,
    required String password,
  }) async {
    final payload = await decodeAndDecryptBackup(
      rawBackup: rawBackup,
      password: password,
    );

    await walletRepository.restoreWalletBackup(payload);
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
