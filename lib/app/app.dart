import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/app/router/app_router.dart';
import 'package:scavium_wallet/app/theme/app_theme.dart';
import 'package:scavium_wallet/app/theme/theme_mode_controller.dart';
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
    final themeModePreference = ref.watch(themeModeControllerProvider);

    return MaterialApp.router(
      title: 'SCAVIUM Wallet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModePreference.themeMode,
      routerConfig: router,
    );
  }
}
