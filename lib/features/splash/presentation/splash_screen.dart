import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/services/local_storage_service.dart';
import 'package:scavium_wallet/core/services/secure_storage_service.dart';
import 'package:scavium_wallet/features/wallet/data/wallet_repository_impl.dart';
import 'package:scavium_wallet/shared/widgets/scavium_logo.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final storage = LocalStorageService();

    final onboardingCompleted = await storage.getBool(
      StorageKeys.onboardingCompleted,
    );

    final repo = WalletRepositoryImpl(
      secureStorage: SecureStorageService(),
      localStorage: storage,
    );

    final profile = await repo.loadWalletProfile();
    final walletCreated = profile != null;

    await Future<void>.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    if (!onboardingCompleted) {
      context.go(RouteNames.onboarding);
      return;
    }

    if (!walletCreated) {
      context.go(RouteNames.walletEntry);
      return;
    }

    context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return const ScaviumScaffold(
      useSafeArea: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaviumLogo(size: 88),
            SizedBox(height: 20),
            Text(
              'SCAVIUM Wallet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
