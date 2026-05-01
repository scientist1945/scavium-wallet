import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/features/wallet/domain/imported_wallet_type.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_account.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_profile.dart';
import 'package:scavium_wallet/features/wallet/presentation/accounts_screen.dart';

void main() {
  testWidgets('renders active wallet account controls', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          walletControllerProvider.overrideWith(_FakeWalletController.new),
        ],
        child: const MaterialApp(home: AccountsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Accounts'), findsOneWidget);
    expect(find.text('Wallet accounts'), findsOneWidget);
    expect(find.text('Active account'), findsOneWidget);
    expect(find.textContaining('Account 1'), findsWidgets);
    expect(find.text('Add account'), findsOneWidget);
    expect(
      find.text('0x1111111111111111111111111111111111111111'),
      findsOneWidget,
    );
  });
}

class _FakeWalletController extends WalletController {
  @override
  Future<WalletProfile?> build() async {
    final account = WalletAccount(
      name: 'Account 1',
      address: '0x1111111111111111111111111111111111111111',
      accountIndex: 0,
      isImportedByPrivateKey: false,
      isDefault: true,
      isActive: true,
    );

    return WalletProfile(
      type: ImportedWalletType.mnemonic,
      account: account,
      hasMnemonic: true,
      biometricEnabled: false,
    );
  }
}
