import 'dart:io';

import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class ScreenshotGuard {
  static Future<void> enableProtection() async {
    if (!Platform.isAndroid) return;
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  static Future<void> disableProtection() async {
    if (!Platform.isAndroid) return;
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }
}
