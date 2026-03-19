import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/app/app.dart';

void bootstrap() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(
    () {
      runApp(const ProviderScope(child: ScaviumWalletApp()));
    },
    (error, stackTrace) {
      debugPrint('Bootstrap error: $error');
      debugPrintStack(stackTrace: stackTrace);
    },
  );
}
