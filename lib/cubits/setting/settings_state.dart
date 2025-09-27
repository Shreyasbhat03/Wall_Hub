

class SettingsState {
  final bool isDark;
  final bool isNotificationsEnabled;
  final bool isAutoWallpaperEnabled;
  final bool isClearCache;
  final String category;
  final String duration;
  final String setAs;

  const SettingsState({
    required this.isDark,
    required this.isNotificationsEnabled,
    required this.isAutoWallpaperEnabled,
    required this.isClearCache,
    required this.category,
    required this.duration,
    this.setAs = "home",
  });

  SettingsState copyWith({
    bool? isDark,
    bool? isNotificationsEnabled,
    bool? isAutoWallpaperEnabled,
    bool? isClearCache,
    String? category,
    String? duration,
    String? setAs,
  }) {
    return SettingsState(
      isDark: isDark ?? this.isDark,
      isNotificationsEnabled: isNotificationsEnabled ?? this.isNotificationsEnabled,
      isAutoWallpaperEnabled: isAutoWallpaperEnabled ?? this.isAutoWallpaperEnabled,
      isClearCache: isClearCache ?? this.isClearCache,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      setAs: setAs ?? this.setAs,
    );
  }
}