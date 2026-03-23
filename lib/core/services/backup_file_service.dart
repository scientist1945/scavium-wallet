import 'dart:convert';

import 'package:scavium_wallet/features/wallet/domain/encrypted_wallet_backup.dart';

class BackupFileService {
  String encodeBackup(EncryptedWalletBackup backup) {
    backup.validate();
    return const JsonEncoder.withIndent('  ').convert(backup.toJson());
  }

  EncryptedWalletBackup decodeBackup(String raw) {
    final decoded = jsonDecode(raw);
    final backup = EncryptedWalletBackup.fromJson(
      Map<String, dynamic>.from(decoded as Map),
    );
    backup.validate();
    return backup;
  }

  String buildDefaultFileName({
    required String address,
    required String network,
    DateTime? now,
  }) {
    final normalized = address.trim().toLowerCase();

    final shortAddress =
        normalized.length >= 10
            ? normalized.substring(normalized.length - 8)
            : normalized;

    final date = (now ?? DateTime.now()).toUtc();
    final dateStr =
        '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';

    return 'scavium_wallet_${network}_$shortAddress\_$dateStr.scwb';
  }
}
