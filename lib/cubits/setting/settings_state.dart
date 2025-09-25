

class SettingsState {
  final bool isDark;
  final bool isNotificationsEnabled;
  final bool isAutoWallpaperEnabled;
  final bool isClearCache;
  final String category;
  final String duration;

  const SettingsState({
    required this.isDark,
    required this.isNotificationsEnabled,
    required this.isAutoWallpaperEnabled,
    required this.isClearCache,
    required this.category,
    required this.duration,
  });

  SettingsState copyWith({
    bool? isDark,
    bool? isNotificationsEnabled,
    bool? isAutoWallpaperEnabled,
    bool? isClearCache,
    String? category,
    String? duration,
  }) {
    return SettingsState(
      isDark: isDark ?? this.isDark,
      isNotificationsEnabled: isNotificationsEnabled ?? this.isNotificationsEnabled,
      isAutoWallpaperEnabled: isAutoWallpaperEnabled ?? this.isAutoWallpaperEnabled,
      isClearCache: isClearCache ?? this.isClearCache,
      category: category ?? this.category,
      duration: duration ?? this.duration,
    );
  }
}