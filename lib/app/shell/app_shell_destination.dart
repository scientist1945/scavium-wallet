import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/router/route_names.dart';

class AppShellDestination {
  final String label;
  final IconData icon;
  final String route;

  const AppShellDestination({
    required this.label,
    required this.icon,
    required this.route,
  });
}

abstract final class AppShellDestinations {
  static const values = <AppShellDestination>[
    AppShellDestination(
      label: 'Home',
      icon: Icons.home_outlined,
      route: RouteNames.home,
    ),
    AppShellDestination(
      label: 'Assets',
      icon: Icons.account_balance_wallet_outlined,
      route: RouteNames.assets,
    ),
    AppShellDestination(
      label: 'Activity',
      icon: Icons.receipt_long_outlined,
      route: RouteNames.history,
    ),
    AppShellDestination(
      label: 'Settings',
      icon: Icons.settings_outlined,
      route: RouteNames.settings,
    ),
  ];

  static int selectedIndexFor(String location) {
    final index = values.indexWhere(
      (destination) => destination.route == location,
    );
    return index < 0 ? 0 : index;
  }
}
