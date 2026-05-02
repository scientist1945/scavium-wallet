import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
      icon: LucideIcons.home,
      route: RouteNames.home,
    ),
    AppShellDestination(
      label: 'Assets',
      icon: LucideIcons.wallet,
      route: RouteNames.assets,
    ),
    AppShellDestination(
      label: 'Activity',
      icon: LucideIcons.receipt,
      route: RouteNames.history,
    ),
    AppShellDestination(
      label: 'Settings',
      icon: LucideIcons.settings,
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
