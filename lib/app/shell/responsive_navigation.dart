import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/shell/app_shell_destination.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';

class ResponsiveNavigation extends StatelessWidget {
  final List<AppShellDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  const ResponsiveNavigation({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 840) {
          return Row(
            children: [
              NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: onDestinationSelected,
                labelType: NavigationRailLabelType.all,
                destinations: destinations
                    .map(
                      (destination) => NavigationRailDestination(
                        icon: Icon(
                          destination.icon,
                          size: ScavoIconSize.sidebar,
                        ),
                        label: Text(destination.label),
                      ),
                    )
                    .toList(growable: false),
              ),
              const VerticalDivider(width: 1),
              Expanded(child: child),
            ],
          );
        }

        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: destinations
                .map(
                  (destination) => NavigationDestination(
                    icon: Icon(destination.icon, size: ScavoIconSize.sidebar),
                    label: destination.label,
                  ),
                )
                .toList(growable: false),
          ),
        );
      },
    );
  }
}
