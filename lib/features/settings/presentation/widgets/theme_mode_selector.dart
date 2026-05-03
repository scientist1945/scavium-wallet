import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';
import 'package:scavium_wallet/app/theme/theme_mode_controller.dart';
import 'package:scavium_wallet/app/theme/theme_mode_preference.dart';

class ThemeModeSelector extends ConsumerWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPreference = ref.watch(themeModeControllerProvider);

    return Semantics(
      label: 'Theme mode',
      value: selectedPreference.label,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: SegmentedButton<ThemeModePreference>(
          showSelectedIcon: true,
          segments: ThemeModePreference.values
              .map(
                (preference) => ButtonSegment<ThemeModePreference>(
                  value: preference,
                  icon: Icon(preference.icon, size: ScavoIconSize.inline),
                  label: Text(preference.label),
                  tooltip: preference.description,
                ),
              )
              .toList(growable: false),
          selected: {selectedPreference},
          onSelectionChanged: (selection) {
            final preference = selection.single;
            ref
                .read(themeModeControllerProvider.notifier)
                .setPreference(preference);
          },
        ),
      ),
    );
  }
}
