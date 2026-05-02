import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/settings/presentation/settings_screen.dart';

void main() {
  testWidgets('renders organized settings sections and safe actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SettingsScreen())),
    );

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Security & recovery'), findsOneWidget);
    expect(find.text('Export encrypted backup'), findsOneWidget);
    expect(find.text('Signing'), findsOneWidget);
    expect(find.text('Sign message'), findsOneWidget);
    expect(find.text('Diagnostics'), findsOneWidget);
    expect(find.text('RPC diagnostics'), findsOneWidget);
    expect(find.text('Danger zone', skipOffstage: false), findsOneWidget);
    expect(find.text('Reset wallet', skipOffstage: false), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.text('About'), findsOneWidget);
    expect(find.text('SCAVIUM Wallet'), findsOneWidget);
  });
}
