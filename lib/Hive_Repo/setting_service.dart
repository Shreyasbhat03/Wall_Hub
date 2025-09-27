import 'package:hive/hive.dart';
import 'package:wallpaper_app/Hive_Repo/settings_model.dart';

class SettingsService {
  final Box<SettingsModel> _settingsBox;

  SettingsService(this._settingsBox);

  SettingsModel get currentSettings =>
      _settingsBox.get('settings') ??
          SettingsModel(
            isDark: false,
            isNotifocationEnabled: true,
            isClearCache: false,
            isAutowallpaperEnabled: false,
            category: "Nature",
            duration: "6h",
            setAs: "home",
          );

  void updateTheme(bool isDark) {
    final updated = currentSettings..isDark = isDark;
    _settingsBox.put('settings', updated);
    print('Updated theme to: $isDark');
  }

  void updateNotifications(bool enabled) {
    final updated = currentSettings..isNotifocationEnabled = enabled;
    _settingsBox.put('settings', updated);
  }

  void updateAutoWallpaper(bool enabled) {
    final updated = currentSettings..isAutowallpaperEnabled = enabled;
    _settingsBox.put('settings', updated);
  }

  void updateClearCache(bool enabled) {
    final updated = currentSettings..isClearCache = enabled;
    _settingsBox.put('settings', updated);
  }

  void updateCategory(String category) {
    final updated = currentSettings..category = category;
    _settingsBox.put('settings', updated);
  }

  void updateSetAs(String setAs) {
    final updated = currentSettings..setAs = setAs;
    _settingsBox.put('settings', updated);
  }

  void updateDuration(String duration) {
    final updated = currentSettings..duration = duration;
    _settingsBox.put('settings', updated);
  }
}
