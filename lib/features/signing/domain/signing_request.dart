import 'package:scavium_wallet/core/errors/app_exception.dart';
import 'package:scavium_wallet/features/signing/domain/signing_mode.dart';

class SigningRequest {
  final SigningMode mode;
  final String message;
  final String accountAddress;

  const SigningRequest({
    required this.mode,
    required this.message,
    required this.accountAddress,
  });

  SigningRequest normalized() {
    final normalizedMessage = message.trim();
    final normalizedAddress = accountAddress.trim();

    if (normalizedMessage.isEmpty) {
      throw const AppException('Signing message cannot be empty');
    }

    if (!_isValidAddress(normalizedAddress)) {
      throw const AppException('Signing account address is invalid');
    }

    return SigningRequest(
      mode: mode,
      message: normalizedMessage,
      accountAddress: normalizedAddress,
    );
  }

  static bool _isValidAddress(String value) {
    return RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value);
  }
}
