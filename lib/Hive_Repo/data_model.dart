import'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId:0)
class ImageModel extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  String imageUrlLarge;
  @HiveField(2)
  String imageUrlMedium;
  @HiveField(3)
  bool isLiked;
  @HiveField(4)
  String photographer;
  @HiveField(5)
  String photoName;
  @HiveField(6)
  DateTime dateTime;

  ImageModel({
    required this.id,
    required this.imageUrlLarge,
    required this.imageUrlMedium,
    required this.isLiked,
    required this.photographer,
    required this.photoName,
    required this.dateTime,
  });
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'].toString(),
      imageUrlLarge: json['src']['large2x'] ?? '',
      imageUrlMedium: json['src']['medium'] ?? '',
      isLiked: false,
      photographer: json['photographer'] ?? '',
      photoName: json['alt'] ?? 'Pexel Image',
      dateTime: DateTime.now(), // Default to current time
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrlLarge': imageUrlLarge,
      'imageUrlMedium': imageUrlMedium,
      'isLiked': isLiked,
      'photographer': photographer,
      'photoName': photoName,
      'dateTime': dateTime.toString(),
    };
  }


}
