import 'package:scavium_wallet/app/theme/theme_mode_preference.dart';
import 'package:scavium_wallet/app/theme/theme_mode_repository.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/services/local_storage_service.dart';

class LocalThemeModeRepository implements ThemeModeRepository {
  const LocalThemeModeRepository(this._storage);

  final LocalStorageService _storage;

  @override
  Future<ThemeModePreference> load() async {
    final value = await _storage.getString(StorageKeys.themeModePreference);
    return ThemeModePreference.fromStorageValue(value);
  }

  @override
  Future<void> save(ThemeModePreference preference) {
    return _storage.setString(
      StorageKeys.themeModePreference,
      preference.storageValue,
    );
  }
}
