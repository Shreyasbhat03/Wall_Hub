// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageModelAdapter extends TypeAdapter<ImageModel> {
  @override
  final int typeId = 0;

  @override
  ImageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageModel(
      id: fields[0] as String,
      imageUrlLarge: fields[1] as String,
      imageUrlMedium: fields[2] as String,
      isLiked: fields[3] as bool,
      photographer: fields[4] as String,
      photoName: fields[5] as String,
      dateTime: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ImageModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageUrlLarge)
      ..writeByte(2)
      ..write(obj.imageUrlMedium)
      ..writeByte(3)
      ..write(obj.isLiked)
      ..writeByte(4)
      ..write(obj.photographer)
      ..writeByte(5)
      ..write(obj.photoName)
      ..writeByte(6)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
