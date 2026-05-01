import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/core/errors/app_exception.dart';
import 'package:scavium_wallet/features/signing/application/signing_controller.dart';
import 'package:scavium_wallet/features/signing/domain/signing_mode.dart';
import 'package:scavium_wallet/features/signing/domain/signing_request.dart';
import 'package:scavium_wallet/features/signing/domain/signing_result.dart';

void main() {
  group('SigningController', () {
    test('signs personal messages through the service boundary', () async {
      final service = _FakeSigningService(
        accountAddress: '0x1111111111111111111111111111111111111111',
      );
      final container = ProviderContainer(
        overrides: [signingServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);

      final result = await container
          .read(signingControllerProvider.notifier)
          .sign(
            const SigningRequest(
              mode: SigningMode.personalMessage,
              message: '  sign me  ',
              accountAddress: '0x1111111111111111111111111111111111111111',
            ),
          );

      expect(result.mode, SigningMode.personalMessage);
      expect(result.message, 'sign me');
      expect(result.signature, '0xsigned-personal');
      expect(service.personalCalls, 1);
      expect(service.challengeCalls, 0);
    });

    test('rejects signatures from an unexpected account', () async {
      final service = _FakeSigningService(
        accountAddress: '0x2222222222222222222222222222222222222222',
      );
      final container = ProviderContainer(
        overrides: [signingServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);

      expect(
        () => container
            .read(signingControllerProvider.notifier)
            .sign(
              const SigningRequest(
                mode: SigningMode.challengeMessage,
                message: 'challenge',
                accountAddress: '0x1111111111111111111111111111111111111111',
              ),
            ),
        throwsA(isA<AppException>()),
      );
    });
  });
}

class _FakeSigningService implements SigningService {
  final String accountAddress;
  int personalCalls = 0;
  int challengeCalls = 0;

  _FakeSigningService({required this.accountAddress});

  @override
  Future<SigningResult> signChallengeMessage(String message) async {
    challengeCalls++;
    return SigningResult(
      mode: SigningMode.challengeMessage,
      accountAddress: accountAddress,
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
      accountAddress: accountAddress,
      message: message,
      signature: '0xsigned-personal',
      signedAt: DateTime.utc(2026, 5, 1),
    );
  }
}
