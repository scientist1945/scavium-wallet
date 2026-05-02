import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/app/theme/theme_mode_preference.dart';
import 'package:scavium_wallet/app/theme/theme_mode_repository.dart';
import 'package:scavium_wallet/core/providers/service_providers.dart';
import 'package:scavium_wallet/features/settings/presentation/widgets/theme_mode_selector.dart';

void main() {
  testWidgets('renders theme mode options and current selection', (
    tester,
  ) async {
    final repository = _ThemeModeRepositoryFake(ThemeModePreference.light);

    await tester.pumpWidget(_harness(repository));
    await tester.pump();

    expect(find.text('System'), findsOneWidget);
    expect(find.text('Light'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);

    final selectedButtons = tester.widgetList<SegmentedButton>(
      find.byType(SegmentedButton<ThemeModePreference>),
    );
    expect(selectedButtons.single.selected, {ThemeModePreference.light});
  });

  testWidgets('updates preference when a mode is selected', (tester) async {
    final repository = _ThemeModeRepositoryFake(ThemeModePreference.system);

    await tester.pumpWidget(_harness(repository));
    await tester.pump();

    await tester.tap(find.text('Dark'));
    await tester.pump();

    expect(repository.savedPreference, ThemeModePreference.dark);
  });
}

Widget _harness(ThemeModeRepository repository) {
  return ProviderScope(
    overrides: [themeModeRepositoryProvider.overrideWithValue(repository)],
    child: const MaterialApp(home: Scaffold(body: ThemeModeSelector())),
  );
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
