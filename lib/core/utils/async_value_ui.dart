import 'package:scavium_wallet/core/errors/app_exception.dart';

String safeAsyncErrorMessage(
  Object? error, {
  String fallback = 'Unable to complete this action. Please try again.',
}) {
  return safeUserFacingError(error, fallback: fallback);
}
