import 'package:scavium_wallet/app/theme/theme_mode_preference.dart';

abstract interface class ThemeModeRepository {
  Future<ThemeModePreference> load();

  Future<void> save(ThemeModePreference preference);
}
