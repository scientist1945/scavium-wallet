class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => 'AppException: $message';
}

String safeUserFacingError(
  Object? error, {
  String fallback = 'Something went wrong. Please try again.',
}) {
  final message =
      error is AppException
          ? error.message
          : error?.toString().replaceFirst('Exception: ', '').trim() ?? '';

  if (message.isEmpty || _containsSensitiveMaterial(message)) {
    return fallback;
  }

  return message.replaceFirst('AppException: ', '');
}

bool _containsSensitiveMaterial(String value) {
  final lower = value.toLowerCase();
  if (lower.contains('privatekey') ||
      lower.contains('private_key') ||
      lower.contains('mnemonic') ||
      lower.contains('recovery phrase') ||
      lower.contains('password') ||
      lower.contains('signature') ||
      lower.contains('ciphertext') ||
      lower.contains('encrypted payload') ||
      lower.contains('backup payload')) {
    return true;
  }

  if (RegExp(r'0x[a-fA-F0-9]{40,}').hasMatch(value)) {
    return true;
  }

  return false;
}
