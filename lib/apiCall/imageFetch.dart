import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper_app/Hive_Repo/data_model.dart';


  Future<List<ImageModel>> fetchImages(String url) async {
    final Dio _dio = Dio();
    final String _apiKey = 'PUT YOUR API KEY FORM PEXEL ';

    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {
          'Authorization': _apiKey,
        }),
      );

      if (response.statusCode == 200) {
        return compute<List<dynamic>, List<ImageModel>>(parsePhotos, response.data['photos']);
      } else {
        throw Exception('Failed to fetch images: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load images: ${e.toString()}');
    }
  }


// This needs to be a top-level function for compute() to work properly
List<ImageModel> parsePhotos(List<dynamic> photosJson) {
  try {
    return photosJson.map<ImageModel>((photo) => ImageModel.fromJson(photo)).toList();
  } catch (e) {
    print('Error parsing photos: $e');
    return [];
  }
}
