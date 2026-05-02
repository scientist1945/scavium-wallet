import 'package:flutter/material.dart';

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
      system => 'Match device settings',
      light => 'Use light appearance',
      dark => 'Use dark appearance',
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
