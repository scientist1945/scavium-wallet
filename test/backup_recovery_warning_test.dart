import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_backup_controller.dart';

void main() {
  group('backup recovery warnings', () {
    test('export errors do not expose secret material', () {
      final message = safeBackupExportErrorMessage(
        Exception(
          'mnemonic=test test private_key=0xabc password=secret encrypted payload',
        ),
      );

      expect(message, contains('Backup export failed'));
      expect(message, isNot(contains('mnemonic')));
      expect(message, isNot(contains('private_key')));
      expect(message, isNot(contains('password=secret')));
      expect(message, isNot(contains('encrypted payload')));
      expect(message, isNot(contains('0xabc')));
    });

    test('restore errors do not expose raw backup content', () {
      final message = safeBackupRestoreErrorMessage(
        Exception(
          '{"ciphertext":"abc","mnemonic":"seed words","password":"secret"}',
        ),
      );

      expect(message, contains('Backup restore failed'));
      expect(message, contains('backup file and password'));
      expect(message, isNot(contains('ciphertext')));
      expect(message, isNot(contains('mnemonic')));
      expect(message, isNot(contains('seed words')));
      expect(message, isNot(contains('secret')));
    });
  });
}
