import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/services/local_storage_service.dart';
import 'package:scavium_wallet/features/assets/domain/asset_item.dart';
import 'package:scavium_wallet/features/assets/domain/token_info.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/presentation/add_token_screen.dart';
import 'package:scavium_wallet/features/assets/presentation/asset_detail_screen.dart';
import 'package:scavium_wallet/features/assets/presentation/assets_screen.dart';
import 'package:scavium_wallet/features/assets/presentation/history_screen.dart';
import 'package:scavium_wallet/features/assets/presentation/send_token_screen.dart';
import 'package:scavium_wallet/features/assets/presentation/transaction_detail_screen.dart';
import 'package:scavium_wallet/features/blockchain/presentation/receive_screen.dart';
import 'package:scavium_wallet/features/blockchain/presentation/rpc_diagnostics_screen.dart';
import 'package:scavium_wallet/features/blockchain/presentation/send_screen.dart';
import 'package:scavium_wallet/features/home/presentation/home_screen.dart';
import 'package:scavium_wallet/features/lock/application/app_lock_state_controller.dart';
import 'package:scavium_wallet/features/lock/presentation/lock_screen.dart';
import 'package:scavium_wallet/features/onboarding/presentation/onboarding_screen.dart';
import 'package:scavium_wallet/features/onboarding/presentation/wallet_entry_screen.dart';
import 'package:scavium_wallet/features/onboarding/presentation/welcome_screen.dart';
import 'package:scavium_wallet/features/settings/presentation/settings_screen.dart';
import 'package:scavium_wallet/features/signing/presentation/signing_screen.dart';
import 'package:scavium_wallet/features/splash/presentation/splash_screen.dart';
import 'package:scavium_wallet/features/wallet/presentation/backup_mnemonic_screen.dart';
import 'package:scavium_wallet/features/wallet/presentation/create_wallet_screen.dart';
import 'package:scavium_wallet/features/wallet/presentation/import_wallet_screen.dart';
import 'package:scavium_wallet/features/wallet/presentation/confirm_mnemonic_screen.dart';
import 'package:scavium_wallet/app/router/router_refresh_notifier.dart';

final routerRefreshNotifierProvider = Provider<RouterRefreshNotifier>((ref) {
  final notifier = RouterRefreshNotifier();

  ref.listen<bool>(appLockStateControllerProvider, (_, _) {
    notifier.refresh();
  });

  return notifier;
});

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    refreshListenable: ref.read(routerRefreshNotifierProvider),
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(path: RouteNames.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (_, _) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.welcome,
        builder: (_, _) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RouteNames.walletEntry,
        builder: (_, _) => const WalletEntryScreen(),
      ),
      GoRoute(
        path: RouteNames.createWallet,
        builder: (_, _) => const CreateWalletScreen(),
      ),
      GoRoute(
        path: RouteNames.importWallet,
        builder: (_, _) => const ImportWalletScreen(),
      ),
      GoRoute(
        path: RouteNames.backupMnemonic,
        builder: (_, _) => const BackupMnemonicScreen(),
      ),
      GoRoute(path: RouteNames.lock, builder: (_, _) => const LockScreen()),
      GoRoute(path: RouteNames.home, builder: (_, _) => const HomeScreen()),
      GoRoute(
        path: RouteNames.settings,
        builder: (_, _) => const SettingsScreen(),
      ),
      GoRoute(path: RouteNames.send, builder: (_, _) => const SendScreen()),
      GoRoute(
        path: RouteNames.receive,
        builder: (_, _) => const ReceiveScreen(),
      ),
      GoRoute(
        path: RouteNames.signing,
        builder: (_, _) => const SigningScreen(),
      ),
      GoRoute(path: RouteNames.assets, builder: (_, _) => const AssetsScreen()),
      GoRoute(
        path: RouteNames.addToken,
        builder: (_, _) => const AddTokenScreen(),
      ),
      GoRoute(
        path: RouteNames.history,
        builder: (_, _) => const HistoryScreen(),
      ),
      GoRoute(
        path: RouteNames.transactionDetail,
        builder:
            (_, state) =>
                TransactionDetailScreen(entry: state.extra as TxHistoryEntry),
      ),
      GoRoute(
        path: RouteNames.assetDetail,
        builder:
            (_, state) => AssetDetailScreen(asset: state.extra as AssetItem),
      ),
      GoRoute(
        path: RouteNames.sendToken,
        builder: (_, state) => SendTokenScreen(token: state.extra as TokenInfo),
      ),
      GoRoute(
        path: RouteNames.confirmMnemonic,
        builder: (_, _) => const ConfirmMnemonicScreen(),
      ),
      GoRoute(
        path: RouteNames.rpcDiagnostics,
        builder: (_, _) => const RpcDiagnosticsScreen(),
      ),
    ],
    redirect: (context, state) async {
      final storage = LocalStorageService();
      final onboardingCompleted = await storage.getBool(
        StorageKeys.onboardingCompleted,
      );
      final walletCreated = await storage.getBool(StorageKeys.walletCreated);
      final current = state.matchedLocation;

      final isLocked = ref.read(appLockStateControllerProvider);

      final isPublicRoute =
          current == RouteNames.splash ||
          current == RouteNames.onboarding ||
          current == RouteNames.welcome ||
          current == RouteNames.walletEntry ||
          current == RouteNames.createWallet ||
          current == RouteNames.importWallet ||
          current == RouteNames.backupMnemonic ||
          current == RouteNames.confirmMnemonic;

      if (!onboardingCompleted && !isPublicRoute) {
        return RouteNames.onboarding;
      }

      if (onboardingCompleted && !walletCreated && current == RouteNames.home) {
        return RouteNames.walletEntry;
      }

      if (walletCreated &&
          isLocked &&
          current != RouteNames.lock &&
          current != RouteNames.splash) {
        return RouteNames.lock;
      }

      if (walletCreated && !isLocked && current == RouteNames.lock) {
        return RouteNames.home;
      }

      return null;
    },
  );
});
