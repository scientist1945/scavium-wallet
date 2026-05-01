import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/signing/application/signing_controller.dart';
import 'package:scavium_wallet/features/signing/domain/signing_mode.dart';
import 'package:scavium_wallet/features/signing/domain/signing_result.dart';
import 'package:scavium_wallet/features/signing/presentation/signing_screen.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/features/wallet/domain/imported_wallet_type.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_account.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_profile.dart';

void main() {
  testWidgets('previews, confirms, and displays a signature', (tester) async {
    final signingService = _FakeSigningService();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          walletControllerProvider.overrideWith(_FakeWalletController.new),
          signingServiceProvider.overrideWithValue(signingService),
        ],
        child: const MaterialApp(home: SigningScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Signing is not a transaction'), findsOneWidget);
    expect(
      find.text('0x1111111111111111111111111111111111111111'),
      findsWidgets,
    );

    await tester.enterText(
      find.byType(TextField),
      '  prove account ownership  ',
    );
    await tester.tap(find.text('Preview and sign'));
    await tester.pumpAndSettle();

    expect(find.text('Confirm signature'), findsOneWidget);
    expect(find.text('prove account ownership'), findsOneWidget);

    await tester.tap(find.text('Sign'));
    await tester.pumpAndSettle();

    expect(signingService.personalCalls, 1);
    expect(signingService.challengeCalls, 0);
    expect(find.text('Signature result'), findsOneWidget);
    expect(find.text('0xsigned-personal'), findsOneWidget);
    expect(find.text('Copy signature'), findsOneWidget);
  });

  testWidgets('cancels signing without calling the service', (tester) async {
    final signingService = _FakeSigningService();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          walletControllerProvider.overrideWith(_FakeWalletController.new),
          signingServiceProvider.overrideWithValue(signingService),
        ],
        child: const MaterialApp(home: SigningScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'cancel this');
    await tester.tap(find.text('Preview and sign'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(signingService.personalCalls, 0);
    expect(signingService.challengeCalls, 0);
    expect(find.text('Signature result'), findsNothing);
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

class _FakeSigningService implements SigningService {
  int personalCalls = 0;
  int challengeCalls = 0;

  @override
  Future<SigningResult> signChallengeMessage(String message) async {
    challengeCalls++;
    return SigningResult(
      mode: SigningMode.challengeMessage,
      accountAddress: '0x1111111111111111111111111111111111111111',
      message: message,
      signature: '0xsigned-challenge',
      signedAt: DateTime.utc(2026, 5, 1),
    );
  }

  @override
  Future<SigningResult> signPersonalMessage(String message) async {
    personalCalls++;
    return SigningResult(
      mode: SigningMode.personalMessage,
      accountAddress: '0x1111111111111111111111111111111111111111',
      message: message,
      signature: '0xsigned-personal',
      signedAt: DateTime.utc(2026, 5, 1),
    );
  }
}
