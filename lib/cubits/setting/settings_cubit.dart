import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/Hive_Repo/setting_service.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsService _settingsService;

  SettingsCubit(this._settingsService)
      : super(SettingsState(
    isDark: _settingsService.currentSettings.isDark ?? false,
    isNotificationsEnabled: _settingsService.currentSettings.isNotifocationEnabled ?? false,
    isAutoWallpaperEnabled: _settingsService.currentSettings.isAutowallpaperEnabled ?? false,
    isClearCache: _settingsService.currentSettings.isClearCache ?? false,
    category: _settingsService.currentSettings.category ?? "Nature",
    duration: _settingsService.currentSettings.duration ?? "6h",
  ));

  // Expose current values as getters from the state
  bool get isDark => state.isDark;
  bool get isNotificationsEnabled => state.isNotificationsEnabled;
  bool get isAutoWallpaperEnabled => state.isAutoWallpaperEnabled;
  bool get isClearCache => state.isClearCache;
  String get category => state.category;
  String get duration => state.duration;

  void toggleTheme(bool isDark) {
    _settingsService.updateTheme(isDark);
    emit(state.copyWith(isDark: isDark));
  }

  void toggleNotifications(bool enabled) {
    _settingsService.updateNotifications(enabled);
    emit(state.copyWith(isNotificationsEnabled: enabled));
  }

  void toggleAutoWallpaper(bool enabled) {
    _settingsService.updateAutoWallpaper(enabled);
    emit(state.copyWith(isAutoWallpaperEnabled: enabled));
  }

  void clearCache(bool enabled) {
    _settingsService.updateClearCache(enabled);
    emit(state.copyWith(isClearCache: enabled));
  }

  void changeCategory(String category) {
    _settingsService.updateCategory(category);
    emit(state.copyWith(category: category));
  }

  void changeDuration(String duration) {
    _settingsService.updateDuration(duration);
    emit(state.copyWith(duration: duration));
  }

  // Method to refresh state from service (useful after app restart)
  void refreshFromService() {
    final current = _settingsService.currentSettings;
    emit(SettingsState(
      isDark: current.isDark ?? false,
      isNotificationsEnabled: current.isNotifocationEnabled ?? false,
      isAutoWallpaperEnabled: current.isAutowallpaperEnabled ?? false,
      isClearCache: current.isClearCache ?? false,
      category: current.category ?? "Nature",
      duration: current.duration ?? "6h",
    ));
  }
}