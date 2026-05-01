import 'package:scavium_wallet/app/router/route_names.dart';

enum AppRouteCategory { primary, secondary, action, detail, public, lock }

abstract final class AppRouteClassifier {
  static const primaryRoutes = <String>{
    RouteNames.home,
    RouteNames.assets,
    RouteNames.history,
    RouteNames.settings,
  };

  static const publicRoutes = <String>{
    RouteNames.splash,
    RouteNames.onboarding,
    RouteNames.welcome,
    RouteNames.walletEntry,
    RouteNames.createWallet,
    RouteNames.importWallet,
    RouteNames.backupMnemonic,
    RouteNames.confirmMnemonic,
  };

  static const actionRoutes = <String>{
    RouteNames.send,
    RouteNames.receive,
    RouteNames.signing,
    RouteNames.addToken,
    RouteNames.sendToken,
  };

  static const detailRoutes = <String>{
    RouteNames.assetDetail,
    RouteNames.transactionDetail,
    RouteNames.rpcDiagnostics,
  };

  static AppRouteCategory categoryFor(String route) {
    if (primaryRoutes.contains(route)) {
      return AppRouteCategory.primary;
    }
    if (publicRoutes.contains(route)) {
      return AppRouteCategory.public;
    }
    if (route == RouteNames.lock) {
      return AppRouteCategory.lock;
    }
    if (actionRoutes.contains(route)) {
      return AppRouteCategory.action;
    }
    if (detailRoutes.contains(route)) {
      return AppRouteCategory.detail;
    }
    return AppRouteCategory.secondary;
  }

  static bool isPrimary(String route) {
    return categoryFor(route) == AppRouteCategory.primary;
  }

  static bool isShellEligible(String route) {
    return switch (categoryFor(route)) {
      AppRouteCategory.primary => true,
      AppRouteCategory.secondary => true,
      AppRouteCategory.action => false,
      AppRouteCategory.detail => false,
      AppRouteCategory.public => false,
      AppRouteCategory.lock => false,
    };
  }
}
