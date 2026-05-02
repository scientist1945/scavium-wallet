import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/shell/app_shell_destination.dart';
import 'package:scavium_wallet/app/shell/responsive_navigation.dart';

class AppShell extends StatelessWidget {
  final String location;
  final Widget child;

  const AppShell({super.key, required this.location, required this.child});

  @override
  Widget build(BuildContext context) {
    final destinations = AppShellDestinations.values;
    final selectedIndex = AppShellDestinations.selectedIndexFor(location);

    return ResponsiveNavigation(
      destinations: destinations,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        final destination = destinations[index];
        if (destination.route != location) {
          context.go(destination.route);
        }
      },
      child: child,
    );
  }
}
