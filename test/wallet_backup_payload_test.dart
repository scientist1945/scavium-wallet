import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_backup_payload.dart';

void main() {
  group('WalletBackupPayload', () {
    test('keeps v1 payloads valid for restore compatibility', () {
      final payload = WalletBackupPayload.v1(
        createdAt: DateTime.utc(2026),
        wallet: const WalletBackupWallet(
          type: 'mnemonic',
          mnemonic: 'test test test test test test test test test test test junk',
          privateKey: null,
          address: '0x1111111111111111111111111111111111111111',
          accountName: 'Main account',
        ),
      );

      expect(payload.version, 1);
      expect(payload.toJson().containsKey('accounts'), isFalse);
      expect(payload.validate, returnsNormally);
    });

    test('serializes and validates account-aware v2 payloads', () {
      final payload = WalletBackupPayload.v2(
        createdAt: DateTime.utc(2026),
        wallet: const WalletBackupWallet(
          type: 'privateKey',
          mnemonic: null,
          privateKey:
              '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
          address: '0x2222222222222222222222222222222222222222',
          accountName: 'Imported account',
        ),
        accounts: const <WalletBackupAccount>[
          WalletBackupAccount(
            id: '0x2222222222222222222222222222222222222222:0',
            name: 'Imported account',
            label: 'Imported account',
            address: '0x2222222222222222222222222222222222222222',
            accountIndex: 0,
            isImportedByPrivateKey: true,
            isDefault: true,
            isActive: true,
            createdAt: null,
            updatedAt: null,
          ),
        ],
        activeAccountId: '0x2222222222222222222222222222222222222222:0',
        defaultAccountId: '0x2222222222222222222222222222222222222222:0',
      );

      final decoded = WalletBackupPayload.fromJson(payload.toJson());

      expect(decoded.version, 2);
      expect(decoded.accounts, hasLength(1));
      expect(decoded.activeAccountId, payload.activeAccountId);
      expect(decoded.defaultAccountId, payload.defaultAccountId);
      expect(decoded.validate, returnsNormally);
    });

    test('rejects v2 payloads whose account list misses the wallet address', () {
      final payload = WalletBackupPayload.v2(
        createdAt: DateTime.utc(2026),
        wallet: const WalletBackupWallet(
          type: 'mnemonic',
          mnemonic: 'test test test test test test test test test test test junk',
          privateKey: null,
          address: '0x3333333333333333333333333333333333333333',
          accountName: 'Main account',
        ),
        accounts: const <WalletBackupAccount>[
          WalletBackupAccount(
            id: '0x4444444444444444444444444444444444444444:0',
            name: 'Other account',
            label: 'Other account',
            address: '0x4444444444444444444444444444444444444444',
            accountIndex: 0,
            isImportedByPrivateKey: false,
            isDefault: true,
            isActive: true,
            createdAt: null,
            updatedAt: null,
          ),
        ],
        activeAccountId: '0x4444444444444444444444444444444444444444:0',
        defaultAccountId: '0x4444444444444444444444444444444444444444:0',
      );

      expect(payload.validate, throwsException);
    });
  });
}
