import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/services/local_storage_service.dart';
import 'package:scavium_wallet/features/home/presentation/home_screen.dart';
import 'package:scavium_wallet/features/lock/presentation/lock_screen.dart';
import 'package:scavium_wallet/features/onboarding/presentation/onboarding_screen.dart';
import 'package:scavium_wallet/features/onboarding/presentation/wallet_entry_screen.dart';
import 'package:scavium_wallet/features/onboarding/presentation/welcome_screen.dart';
import 'package:scavium_wallet/features/settings/presentation/settings_screen.dart';
import 'package:scavium_wallet/features/splash/presentation/splash_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final storage = LocalStorageService();

  return GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.welcome,
        builder: (_, __) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RouteNames.walletEntry,
        builder: (_, __) => const WalletEntryScreen(),
      ),
      GoRoute(path: RouteNames.lock, builder: (_, __) => const LockScreen()),
      GoRoute(path: RouteNames.home, builder: (_, __) => const HomeScreen()),
      GoRoute(
        path: RouteNames.settings,
        builder: (_, __) => const SettingsScreen(),
      ),
    ],
    redirect: (context, state) async {
      final onboardingCompleted = await storage.getBool(
        StorageKeys.onboardingCompleted,
      );
      final walletCreated = await storage.getBool(StorageKeys.walletCreated);

      final current = state.matchedLocation;

      if (!onboardingCompleted &&
          current != RouteNames.splash &&
          current != RouteNames.onboarding &&
          current != RouteNames.welcome &&
          current != RouteNames.walletEntry) {
        return RouteNames.onboarding;
      }

      if (onboardingCompleted && !walletCreated && current == RouteNames.home) {
        return RouteNames.walletEntry;
      }

      return null;
    },
  );
});
