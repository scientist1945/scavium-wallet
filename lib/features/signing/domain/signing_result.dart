import 'package:scavium_wallet/features/signing/domain/signing_mode.dart';

class SigningResult {
  final SigningMode mode;
  final String accountAddress;
  final String message;
  final String signature;
  final DateTime signedAt;

  const SigningResult({
    required this.mode,
    required this.accountAddress,
    required this.message,
    required this.signature,
    required this.signedAt,
  });
}
