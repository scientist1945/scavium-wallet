import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/app/theme/theme_mode_preference.dart';
import 'package:scavium_wallet/app/theme/theme_mode_repository.dart';
import 'package:scavium_wallet/core/app_identity/app_version_info.dart';
import 'package:scavium_wallet/core/app_identity/app_version_provider.dart';
import 'package:scavium_wallet/core/providers/service_providers.dart';
import 'package:scavium_wallet/features/settings/presentation/settings_screen.dart';

void main() {
  testWidgets('renders organized settings sections and safe actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appVersionInfoProvider.overrideWith(
            (ref) async => const AppVersionInfo(
              appName: 'SCAVIUM Wallet',
              semanticVersion: '0.2.2',
              buildNumber: '1',
            ),
          ),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(
      find.text('Choose how SCAVIUM Wallet follows your device display.'),
      findsOneWidget,
    );
    expect(find.text('System'), findsOneWidget);
    expect(find.text('Light'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);
    expect(find.text('Security & recovery'), findsOneWidget);
    expect(
      find.text(
        'Export recovery material only when you are ready to store it securely.',
      ),
      findsOneWidget,
    );
    expect(find.text('Export encrypted backup'), findsOneWidget);
    expect(find.text('Signing'), findsOneWidget);
    expect(find.text('Sign message'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.text('Diagnostics'), findsOneWidget);
    expect(
      find.text('Inspect network health without changing wallet data.'),
      findsOneWidget,
    );
    expect(find.text('RPC diagnostics'), findsOneWidget);
    expect(find.text('Danger zone'), findsOneWidget);
    expect(find.text('Reset wallet'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -700));
    await tester.pumpAndSettle();

    expect(find.text('About'), findsOneWidget);
    expect(find.text('SCAVIUM Wallet'), findsOneWidget);
    expect(find.text('SCAVIUM Wallet 0.2.2 (1)'), findsOneWidget);
    expect(find.text('Version 0.4.0'), findsNothing);
  });

  testWidgets('renders deterministic fallback while version is loading', (
    tester,
  ) async {
    final pendingVersion = Completer<AppVersionInfo>();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appVersionInfoProvider.overrideWith((ref) => pendingVersion.future),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    await tester.drag(find.byType(ListView), const Offset(0, -900));
    await tester.pump();

    expect(find.text('About'), findsOneWidget);
    expect(find.text('SCAVIUM Wallet'), findsOneWidget);
    expect(find.text('Version unavailable'), findsOneWidget);
    expect(find.text('Version 0.4.0'), findsNothing);
  });

  testWidgets('renders version from provider override only', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appVersionInfoProvider.overrideWith(
            (ref) async => const AppVersionInfo(
              appName: 'SCAVIUM Wallet',
              semanticVersion: '7.8.9',
              buildNumber: '42',
            ),
          ),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -900));
    await tester.pumpAndSettle();

    expect(find.text('SCAVIUM Wallet 7.8.9 (42)'), findsOneWidget);
    expect(find.text('SCAVIUM Wallet 0.2.2 (1)'), findsNothing);
  });

  testWidgets('updates theme mode from appearance selector', (tester) async {
    final themeModeRepository = _ThemeModeRepositoryFake(
      ThemeModePreference.system,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appVersionInfoProvider.overrideWith(
            (ref) async => const AppVersionInfo(
              appName: 'SCAVIUM Wallet',
              semanticVersion: '0.2.2',
              buildNumber: '1',
            ),
          ),
          themeModeRepositoryProvider.overrideWithValue(themeModeRepository),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Dark'));
    await tester.pump();

    expect(themeModeRepository.savedPreference, ThemeModePreference.dark);
  });
}

class _ThemeModeRepositoryFake implements ThemeModeRepository {
  _ThemeModeRepositoryFake(this.preference);

  ThemeModePreference preference;
  ThemeModePreference? savedPreference;

  @override
  Future<ThemeModePreference> load() async {
    return preference;
  }

  @override
  Future<void> save(ThemeModePreference preference) async {
    savedPreference = preference;
    this.preference = preference;
  }
}
