
abstract class SettingsState {}

final class SettingsInitial extends SettingsState {}
final class AppThemeState extends SettingsState{
   final bool isDark;
  AppThemeState({required this.isDark});
}
final class NotificationEnabledState extends SettingsState{
  final bool isNotifocationEnabled;
  NotificationEnabledState({required this.isNotifocationEnabled});
}

final class clearCacheState extends SettingsState{
 final bool isClearCache;
  clearCacheState({required this.isClearCache});
}
final class AutoWallpaperSetState extends SettingsState{
   final bool isAutowallpaperEnabled;
   String? category;
   String? duration;
   AutoWallpaperSetState({required this.isAutowallpaperEnabled,this.duration,this.category});
}