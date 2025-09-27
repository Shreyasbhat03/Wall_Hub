import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/Hive_Repo/setting_service.dart';
import 'package:wallpaper_app/notificationService/notification.dart';
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
    setAs: _settingsService.currentSettings.setAs ?? "home",
  ));

  // Expose current values as getters from the state
  bool get isDark => state.isDark;
  bool get isNotificationsEnabled => state.isNotificationsEnabled;
  bool get isAutoWallpaperEnabled => state.isAutoWallpaperEnabled;
  bool get isClearCache => state.isClearCache;
  String get category => state.category;
  String get duration => state.duration;
  String get setAs => state.setAs;

  void toggleTheme(bool isDark) {
    _settingsService.updateTheme(isDark);
    emit(state.copyWith(isDark: isDark));
  }

  Future<void> toggleNotifications(bool enabled) async {
    if (enabled) {
      // Check if device permissions are granted
      final permissionGranted = await NotificationService.areNotificationsEnabled();
      if (!permissionGranted) {
        // Request permissions
        await NotificationService.requestAndroidPermissions();

        // Check again after requesting
        final stillNotGranted = await NotificationService.areNotificationsEnabled();
        if (!stillNotGranted) {
          // If still not granted, show a message and don't enable
          await NotificationService.showInstantNotification(
            id: 1,
            title: 'Permission Required',
            body: 'Please enable notifications in app settings to receive wallpaper updates',
          );
          return;
        }
      }

      // If notifications are enabled and auto wallpaper is on, schedule notifications
      if (state.isAutoWallpaperEnabled) {
        await _scheduleWallpaperNotifications();
      }

      // Show welcome notification
      await NotificationService.showInstantNotification(
        id: 2,
        title: 'Notifications Enabled! 🔔',
        body: 'You\'ll now receive wallpaper update reminders',
      );
    } else {
      // Cancel all notifications when disabled
      await NotificationService.cancelAllNotifications();
    }

    _settingsService.updateNotifications(enabled);
    emit(state.copyWith(isNotificationsEnabled: enabled));
  }

  Future<void> toggleAutoWallpaper(bool enabled) async {
    _settingsService.updateAutoWallpaper(enabled);

    if (enabled && state.isNotificationsEnabled) {
      // Schedule wallpaper change notifications
      await _scheduleWallpaperNotifications();

      await NotificationService.showInstantNotification(
        id: 3,
        title: 'Auto Wallpaper Enabled! 🎨',
        body: 'Your wallpaper will change automatically every ${state.duration}',
      );
    } else if (!enabled) {
      // Cancel wallpaper notifications
      await NotificationService.cancelNotification(999);
    }

    emit(state.copyWith(isAutoWallpaperEnabled: enabled));
  }

  Future<void> clearCache(bool enabled) async {
    if (enabled) {
      // Perform cache clearing logic here
      // This could involve deleting cached images, temporary files, etc.

      if (state.isNotificationsEnabled) {
        await NotificationService.showInstantNotification(
          id: 4,
          title: 'Cache Cleared! 🧹',
          body: 'Your app cache has been cleared successfully',
        );
      }
    }

    _settingsService.updateClearCache(enabled);
    emit(state.copyWith(isClearCache: enabled));
  }
  Future<void> changeSetAs(String setAs) async {
    _settingsService.updateSetAs(setAs);
    if (state.isAutoWallpaperEnabled && state.isNotificationsEnabled) {
      await _scheduleWallpaperNotifications();

      await NotificationService.showInstantNotification(
        id: 7,
        title: 'Set As Updated! 🖼️',
        body: 'Wallpaper will now change on your $setAs screen',
      );
    }

    emit(state.copyWith(setAs: setAs));
  }

  Future<void> changeCategory(String category) async {
    _settingsService.updateCategory(category);

    // If auto wallpaper is enabled, reschedule with new category
    if (state.isAutoWallpaperEnabled && state.isNotificationsEnabled) {
      await _scheduleWallpaperNotifications();

      await NotificationService.showInstantNotification(
        id: 5,
        title: 'Category Updated! 📂',
        body: 'Now showing $category wallpapers',
      );
    }

    emit(state.copyWith(category: category));
  }

  Future<void> changeDuration(String duration) async {
    _settingsService.updateDuration(duration);

    // If auto wallpaper is enabled, reschedule with new duration
    if (state.isAutoWallpaperEnabled && state.isNotificationsEnabled) {
      await _scheduleWallpaperNotifications();

      await NotificationService.showInstantNotification(
        id: 6,
        title: 'Duration Updated! ⏰',
        body: 'Wallpaper will now change every $duration',
      );
    }

    emit(state.copyWith(duration: duration));
  }

  // Helper method to schedule wallpaper notifications
  Future<void> _scheduleWallpaperNotifications() async {
    final duration = _parseDuration(state.duration);
    await NotificationService.scheduleWallpaperChangeNotification(
      interval: duration,
      category: state.category,
      setAs: state.setAs,
    );
  }

  // Helper method to parse duration string to Duration object
  Duration _parseDuration(String durationStr) {
    final number = int.tryParse(durationStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 6;

    if (durationStr.contains('h')) {
      return Duration(hours: number);
    } else if (durationStr.contains('m')) {
      return Duration(minutes: number);
    } else if (durationStr.contains('d')) {
      return Duration(days: number);
    }

    return Duration(hours: number); // Default to hours
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
      setAs: current.setAs ?? "home",
    ));
  }
}