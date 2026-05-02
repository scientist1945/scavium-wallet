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
    expect(find.byTooltip('Match your device setting'), findsOneWidget);
    expect(find.byTooltip('Always use light mode'), findsOneWidget);
    expect(find.byTooltip('Always use dark mode'), findsOneWidget);

    final selectedButtons = tester.widgetList<SegmentedButton>(
      find.byType(SegmentedButton<ThemeModePreference>),
    );
    final selector = selectedButtons.single;
    expect(selector.selected, {ThemeModePreference.light});
    expect(selector.showSelectedIcon, isTrue);
    expect(selector.segments.map((segment) => (segment.icon! as Icon).icon), [
      Icons.brightness_auto_outlined,
      Icons.light_mode_outlined,
      Icons.dark_mode_outlined,
    ]);
  });

  testWidgets('exposes accessible current theme mode value', (tester) async {
    final repository = _ThemeModeRepositoryFake(ThemeModePreference.dark);

    await tester.pumpWidget(_harness(repository));
    await tester.pump();

    expect(
      tester.getSemantics(find.byType(ThemeModeSelector)),
      matchesSemantics(label: 'Theme mode', value: 'Dark'),
    );
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
