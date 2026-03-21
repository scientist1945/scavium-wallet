import 'dart:io';

import 'package:flutter/services.dart';

class ScreenshotGuard {
  static const MethodChannel _channel = MethodChannel(
    'scavium_wallet/security',
  );

  static Future<void> enableProtection() async {
    if (!Platform.isAndroid) return;
    await _channel.invokeMethod('enableScreenshotProtection');
  }

  static Future<void> disableProtection() async {
    if (!Platform.isAndroid) return;
    await _channel.invokeMethod('disableScreenshotProtection');
  }
}
