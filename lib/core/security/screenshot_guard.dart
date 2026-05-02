import 'dart:io';

import 'package:flutter/services.dart';

class ScreenshotGuard {
  static const MethodChannel _channel = MethodChannel(
    'scavium_wallet/security',
  );

  static Future<void> enableProtection() async {
    if (!Platform.isAndroid) return;
    await _tryInvoke('enableScreenshotProtection');
  }

  static Future<void> disableProtection() async {
    if (!Platform.isAndroid) return;
    await _tryInvoke('disableScreenshotProtection');
  }

  static Future<void> _tryInvoke(String method) async {
    try {
      await _channel.invokeMethod(method);
    } on PlatformException {
      return;
    } on MissingPluginException {
      return;
    }
  }
}
