import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum ThemeModePreference {
  system('system', ThemeMode.system),
  light('light', ThemeMode.light),
  dark('dark', ThemeMode.dark);

  const ThemeModePreference(this.storageValue, this.themeMode);

  final String storageValue;
  final ThemeMode themeMode;

  static const fallback = system;

  String get label {
    return switch (this) {
      system => 'System',
      light => 'Light',
      dark => 'Dark',
    };
  }

  String get description {
    return switch (this) {
      system => 'Match your device setting',
      light => 'Always use light mode',
      dark => 'Always use dark mode',
    };
  }

  IconData get icon {
    return switch (this) {
      system => LucideIcons.monitor,
      light => LucideIcons.sun,
      dark => LucideIcons.moon,
    };
  }

  static ThemeModePreference fromStorageValue(String? value) {
    if (value == null) {
      return fallback;
    }

    final normalized = value.trim();
    for (final preference in values) {
      if (preference.storageValue == normalized) {
        return preference;
      }
    }

    return fallback;
  }
}
