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
      find.textContaining('does not submit a transaction'),
      findsOneWidget,
    );
    expect(find.textContaining('Never sign a message'), findsOneWidget);
    expect(find.textContaining('Personal messages'), findsOneWidget);
    expect(
      find.text('0x1111111111111111111111111111111111111111'),
      findsWidgets,
    );

    await tester.enterText(
      find.byType(TextField),
      '  prove account ownership  ',
    );
    await _tapPreviewAndSign(tester);
    await tester.pumpAndSettle();

    expect(find.text('Confirm signature'), findsOneWidget);
    expect(find.text('prove account ownership'), findsOneWidget);
    expect(find.textContaining('does not send a transaction'), findsOneWidget);
    expect(find.textContaining('recognize the full text'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Sign'));
    await tester.pumpAndSettle();

    expect(signingService.personalCalls, 1);
    expect(signingService.challengeCalls, 0);
    expect(find.text('Signature result'), findsOneWidget);
    expect(find.text('0xsigned-personal'), findsOneWidget);
    expect(find.textContaining('not a transaction receipt'), findsOneWidget);
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
    await _tapPreviewAndSign(tester);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(signingService.personalCalls, 0);
    expect(signingService.challengeCalls, 0);
    expect(find.text('Signature result'), findsNothing);
  });

  testWidgets('shows challenge-specific safety copy', (tester) async {
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

    await tester.tap(find.text('Challenge'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Challenges should come from'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'challenge-123');
    await _tapPreviewAndSign(tester);
    await tester.pumpAndSettle();

    expect(
      find.textContaining('came from the service you are intentionally'),
      findsOneWidget,
    );
    expect(signingService.personalCalls, 0);
    expect(signingService.challengeCalls, 0);
  });
}

Future<void> _tapPreviewAndSign(WidgetTester tester) async {
  final button = find.widgetWithText(FilledButton, 'Preview and sign');

  await tester.scrollUntilVisible(
    button,
    120,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
  await tester.tap(button);
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
