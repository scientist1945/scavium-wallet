import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/assets/domain/asset_account_context.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_account.dart';

void main() {
  group('AssetAccountContext', () {
    test('derives display metadata from an active wallet account', () {
      final account = WalletAccount(
        name: 'Account 1',
        label: 'Treasury',
        address: '0x1234567890abcdef1234567890abcdef12345678',
        accountIndex: 0,
        isImportedByPrivateKey: false,
        isDefault: true,
        isActive: true,
      );

      final context = AssetAccountContext.fromWalletAccount(account);

      expect(context.accountId, account.id);
      expect(context.displayName, 'Treasury');
      expect(context.shortAddress, '0x123456...345678');
    });

    test('falls back to account name when label is empty', () {
      final account = WalletAccount(
        name: 'Account 2',
        label: '',
        address: '0xabc',
        accountIndex: 1,
        isImportedByPrivateKey: true,
      );

      final context = AssetAccountContext.fromWalletAccount(account);

      expect(context.displayName, 'Account 2');
      expect(context.shortAddress, '0xabc');
    });
  });
}
