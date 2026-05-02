import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';

abstract final class AppSnackbar {
  static void showInfo(BuildContext context, String message) {
    _show(context, message, ScavoColors.semanticInfo);
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, ScavoColors.semanticSuccess);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, ScavoColors.semanticDanger);
  }

  static void _show(BuildContext context, String message, Color borderColor) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.sm),
          side: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}
