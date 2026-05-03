import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/app/theme/theme_mode_preference.dart';
import 'package:scavium_wallet/app/theme/theme_mode_repository_impl.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ThemeModePreference', () {
    test('uses stable storage values', () {
      expect(ThemeModePreference.system.storageValue, 'system');
      expect(ThemeModePreference.light.storageValue, 'light');
      expect(ThemeModePreference.dark.storageValue, 'dark');
    });

    test('exposes clear display labels and descriptions', () {
      expect(ThemeModePreference.system.label, 'System');
      expect(
        ThemeModePreference.system.description,
        'Match your device setting',
      );
      expect(ThemeModePreference.light.label, 'Light');
      expect(ThemeModePreference.light.description, 'Always use light mode');
      expect(ThemeModePreference.dark.label, 'Dark');
      expect(ThemeModePreference.dark.description, 'Always use dark mode');
    });

    test('maps values to Flutter ThemeMode', () {
      expect(ThemeModePreference.system.themeMode, ThemeMode.system);
      expect(ThemeModePreference.light.themeMode, ThemeMode.light);
      expect(ThemeModePreference.dark.themeMode, ThemeMode.dark);
    });

    test('parses supported storage values', () {
      expect(
        ThemeModePreference.fromStorageValue('system'),
        ThemeModePreference.system,
      );
      expect(
        ThemeModePreference.fromStorageValue('light'),
        ThemeModePreference.light,
      );
      expect(
        ThemeModePreference.fromStorageValue('dark'),
        ThemeModePreference.dark,
      );
    });

    test('falls back to system for missing or invalid values', () {
      expect(
        ThemeModePreference.fromStorageValue(null),
        ThemeModePreference.system,
      );
      expect(
        ThemeModePreference.fromStorageValue(''),
        ThemeModePreference.system,
      );
      expect(
        ThemeModePreference.fromStorageValue('invalid'),
        ThemeModePreference.system,
      );
      expect(
        ThemeModePreference.fromStorageValue('system '),
        ThemeModePreference.system,
      );
    });
  });

  group('LocalThemeModeRepository', () {
    test('falls back to system when nothing is stored', () async {
      SharedPreferences.setMockInitialValues({});
      final repository = LocalThemeModeRepository(LocalStorageService());

      final preference = await repository.load();

      expect(preference, ThemeModePreference.system);
    });

    test('loads stored preference value', () async {
      SharedPreferences.setMockInitialValues({
        StorageKeys.themeModePreference: ThemeModePreference.light.storageValue,
      });
      final repository = LocalThemeModeRepository(LocalStorageService());

      final preference = await repository.load();

      expect(preference, ThemeModePreference.light);
    });

    test('saves preference as stable local string', () async {
      SharedPreferences.setMockInitialValues({});
      final repository = LocalThemeModeRepository(LocalStorageService());

      await repository.save(ThemeModePreference.dark);

      final prefs = await SharedPreferences.getInstance();
      expect(
        prefs.getString(StorageKeys.themeModePreference),
        ThemeModePreference.dark.storageValue,
      );
    });
  });
}
