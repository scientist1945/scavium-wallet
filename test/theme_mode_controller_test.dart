import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/app/theme/theme_mode_controller.dart';
import 'package:scavium_wallet/app/theme/theme_mode_preference.dart';
import 'package:scavium_wallet/app/theme/theme_mode_repository.dart';
import 'package:scavium_wallet/core/providers/service_providers.dart';

void main() {
  group('ThemeModeController', () {
    test('uses system while persisted preference is loading', () {
      final repository = _FakeThemeModeRepository(
        loadCompleter: Completer<ThemeModePreference>(),
      );
      final container = _container(repository);
      addTearDown(container.dispose);

      final preference = container.read(themeModeControllerProvider);

      expect(preference, ThemeModePreference.system);
    });

    test('loads persisted preference reactively', () async {
      final loadCompleter = Completer<ThemeModePreference>();
      final repository = _FakeThemeModeRepository(loadCompleter: loadCompleter);
      final container = _container(repository);
      addTearDown(container.dispose);

      expect(
        container.read(themeModeControllerProvider),
        ThemeModePreference.system,
      );

      loadCompleter.complete(ThemeModePreference.dark);
      await Future<void>.delayed(Duration.zero);

      expect(
        container.read(themeModeControllerProvider),
        ThemeModePreference.dark,
      );
    });

    test('updates state and persists selection', () async {
      final repository = _FakeThemeModeRepository(
        loadCompleter: Completer<ThemeModePreference>(),
      );
      final container = _container(repository);
      addTearDown(container.dispose);

      await container
          .read(themeModeControllerProvider.notifier)
          .setPreference(ThemeModePreference.light);

      expect(
        container.read(themeModeControllerProvider),
        ThemeModePreference.light,
      );
      expect(repository.savedPreference, ThemeModePreference.light);
    });

    test(
      'does not let initial load overwrite a newer local selection',
      () async {
        final loadCompleter = Completer<ThemeModePreference>();
        final repository = _FakeThemeModeRepository(
          loadCompleter: loadCompleter,
        );
        final container = _container(repository);
        addTearDown(container.dispose);

        await container
            .read(themeModeControllerProvider.notifier)
            .setPreference(ThemeModePreference.light);

        loadCompleter.complete(ThemeModePreference.dark);
        await Future<void>.delayed(Duration.zero);

        expect(
          container.read(themeModeControllerProvider),
          ThemeModePreference.light,
        );
        expect(repository.savedPreference, ThemeModePreference.light);
      },
    );
  });
}

ProviderContainer _container(ThemeModeRepository repository) {
  return ProviderContainer(
    overrides: [themeModeRepositoryProvider.overrideWithValue(repository)],
  );
}

class _FakeThemeModeRepository implements ThemeModeRepository {
  _FakeThemeModeRepository({required this.loadCompleter});

  final Completer<ThemeModePreference> loadCompleter;
  ThemeModePreference? savedPreference;

  @override
  Future<ThemeModePreference> load() {
    return loadCompleter.future;
  }

  @override
  Future<void> save(ThemeModePreference preference) async {
    savedPreference = preference;
  }
}
