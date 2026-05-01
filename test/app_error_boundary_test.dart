import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/core/errors/app_exception.dart';
import 'package:scavium_wallet/core/utils/async_value_ui.dart';

void main() {
  group('safeUserFacingError', () {
    test('keeps explicit app messages', () {
      final message = safeUserFacingError(
        const AppException('Check the amount and try again.'),
      );

      expect(message, 'Check the amount and try again.');
    });

    test('hides sensitive values from user-facing errors', () {
      final message = safeAsyncErrorMessage(
        Exception(
          'failed for 0x1111111111111111111111111111111111111111 private_key=secret signature=0xsigned',
        ),
        fallback: 'Action failed safely.',
      );

      expect(message, 'Action failed safely.');
      expect(
        message,
        isNot(contains('0x1111111111111111111111111111111111111111')),
      );
      expect(message, isNot(contains('private_key')));
      expect(message, isNot(contains('signature')));
      expect(message, isNot(contains('secret')));
    });
  });
}
