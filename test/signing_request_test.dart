import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/core/errors/app_exception.dart';
import 'package:scavium_wallet/features/signing/domain/signing_mode.dart';
import 'package:scavium_wallet/features/signing/domain/signing_request.dart';

void main() {
  group('SigningRequest', () {
    test('normalizes message and account address', () {
      final request =
          const SigningRequest(
            mode: SigningMode.personalMessage,
            message: '  hello scavium  ',
            accountAddress: '  0x1111111111111111111111111111111111111111  ',
          ).normalized();

      expect(request.mode, SigningMode.personalMessage);
      expect(request.message, 'hello scavium');
      expect(
        request.accountAddress,
        '0x1111111111111111111111111111111111111111',
      );
    });

    test('rejects empty messages', () {
      expect(
        () =>
            const SigningRequest(
              mode: SigningMode.challengeMessage,
              message: '   ',
              accountAddress: '0x1111111111111111111111111111111111111111',
            ).normalized(),
        throwsA(isA<AppException>()),
      );
    });

    test('rejects messages over the safety limit', () {
      expect(
        () =>
            SigningRequest(
              mode: SigningMode.personalMessage,
              message: 'a' * (SigningRequest.maxMessageLength + 1),
              accountAddress: '0x1111111111111111111111111111111111111111',
            ).normalized(),
        throwsA(isA<AppException>()),
      );
    });

    test('rejects invalid account addresses', () {
      expect(
        () =>
            const SigningRequest(
              mode: SigningMode.personalMessage,
              message: 'hello',
              accountAddress: 'not-an-address',
            ).normalized(),
        throwsA(isA<AppException>()),
      );
    });
  });
}
