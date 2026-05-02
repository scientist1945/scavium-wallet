import 'package:flutter/material.dart';

abstract final class AppSnackbar {
  static void showInfo(BuildContext context, String message) {
    _show(context, message, Theme.of(context).colorScheme.primary);
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, Theme.of(context).colorScheme.tertiary);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, Theme.of(context).colorScheme.error);
  }

  static void _show(BuildContext context, String message, Color borderColor) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: _snackbarShape(context, borderColor),
      ),
    );
  }

  static ShapeBorder _snackbarShape(BuildContext context, Color borderColor) {
    final shape = Theme.of(context).snackBarTheme.shape;
    if (shape is RoundedRectangleBorder) {
      return shape.copyWith(side: BorderSide(color: borderColor));
    }

    return RoundedRectangleBorder(side: BorderSide(color: borderColor));
  }
}
