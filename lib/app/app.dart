import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/app/router/app_router.dart';
import 'package:scavium_wallet/app/theme/app_theme.dart';
import 'package:scavium_wallet/core/security/app_lifecycle_guard.dart';

class ScaviumWalletApp extends ConsumerStatefulWidget {
  const ScaviumWalletApp({super.key});

  @override
  ConsumerState<ScaviumWalletApp> createState() => _ScaviumWalletAppState();
}

class _ScaviumWalletAppState extends ConsumerState<ScaviumWalletApp> {
  AppLifecycleGuard? _guard;

  @override
  void initState() {
    super.initState();
    _guard = AppLifecycleGuard(ref);
    WidgetsBinding.instance.addObserver(_guard!);
  }

  @override
  void dispose() {
    if (_guard != null) {
      WidgetsBinding.instance.removeObserver(_guard!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'SCAVIUM Wallet',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
