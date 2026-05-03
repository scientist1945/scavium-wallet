import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/app/theme/theme_mode_preference.dart';
import 'package:scavium_wallet/app/theme/theme_mode_repository.dart';
import 'package:scavium_wallet/core/providers/service_providers.dart';

final themeModeControllerProvider =
    NotifierProvider<ThemeModeController, ThemeModePreference>(
      ThemeModeController.new,
    );

class ThemeModeController extends Notifier<ThemeModePreference> {
  late final ThemeModeRepository _repository;
  var _hasLocalSelection = false;

  @override
  ThemeModePreference build() {
    _repository = ref.watch(themeModeRepositoryProvider);
    _loadPersistedPreference();
    return ThemeModePreference.fallback;
  }

  Future<void> setPreference(ThemeModePreference preference) async {
    _hasLocalSelection = true;
    state = preference;
    await _repository.save(preference);
  }

  Future<void> _loadPersistedPreference() async {
    final preference = await _repository.load();
    if (_hasLocalSelection) {
      return;
    }

    state = preference;
  }
}
