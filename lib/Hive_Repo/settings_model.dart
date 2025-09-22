import 'package:hive_flutter/hive_flutter.dart';
part 'settings_model.g.dart';

@HiveType(typeId:1)
class SettingsModel extends HiveObject{
  @HiveField(0)
   bool? isDark;
  @HiveField(1)
  bool? isNotifocationEnabled;
  @HiveField(2)
  bool? isClearCache;
  @HiveField(3)
  bool? isAutowallpaperEnabled;
  @HiveField(4)
  String? category;
  @HiveField(5)
  String? duration;

  SettingsModel(
  {  this.isDark=false,
    this.isNotifocationEnabled=true,
    this.isClearCache=false,
    this.isAutowallpaperEnabled=false,
    this.category,
    this.duration
  }
      );

}