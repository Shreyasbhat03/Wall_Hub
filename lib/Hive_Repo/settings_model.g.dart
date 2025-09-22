// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 1;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      isDark: fields[0] as bool?,
      isNotifocationEnabled: fields[1] as bool?,
      isClearCache: fields[2] as bool?,
      isAutowallpaperEnabled: fields[3] as bool?,
      category: fields[4] as String?,
      duration: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isDark)
      ..writeByte(1)
      ..write(obj.isNotifocationEnabled)
      ..writeByte(2)
      ..write(obj.isClearCache)
      ..writeByte(3)
      ..write(obj.isAutowallpaperEnabled)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
