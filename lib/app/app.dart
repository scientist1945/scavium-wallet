import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/app/router/app_router.dart';
import 'package:scavium_wallet/app/theme/app_theme.dart';

class ScaviumWalletApp extends ConsumerWidget {
  const ScaviumWalletApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
