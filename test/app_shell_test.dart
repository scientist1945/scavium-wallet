import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/app/shell/app_shell.dart';
import 'package:scavium_wallet/app/shell/app_shell_destination.dart';

void main() {
  group('AppShell', () {
    testWidgets('renders primary navigation destinations', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppShell(
            location: RouteNames.home,
            child: Text('Primary content'),
          ),
        ),
      );

      expect(find.text('Primary content'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Assets'), findsOneWidget);
      expect(find.text('Activity'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    test('selects the current primary destination by route', () {
      expect(AppShellDestinations.selectedIndexFor(RouteNames.home), 0);
      expect(AppShellDestinations.selectedIndexFor(RouteNames.assets), 1);
      expect(AppShellDestinations.selectedIndexFor(RouteNames.history), 2);
      expect(AppShellDestinations.selectedIndexFor(RouteNames.settings), 3);
    });
  });
}
