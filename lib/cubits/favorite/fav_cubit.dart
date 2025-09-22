import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/Hive_Repo/data_model.dart';
part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());
  List<ImageModel> allImages = [];

  Future<void> loadImages() async {
    emit(FavLoading());
    try {
      final box = Hive.box<ImageModel>('FavImages');
      allImages = box.values.toList();
      print("Loaded images: $allImages");
      emit(FavLoaded(images: allImages));
    } catch (e) {
      emit(FavError(error: e.toString()));
    }
  }

  Future<void> removeFromFavorites(String id) async {
    try {
      final box = Hive.box<ImageModel>('FavImages');

      // Print all keys to see what's in the box
      print("All keys in box: ${box.keys.toList()}");

      // Check if the ID exists directly
      final exists = box.containsKey(id);
      print("Image with id: $id exists: $exists");

      if (exists) {
        await box.delete(id);
        final updatedList = box.values.toList();
        print("Deleted image with id: $id");
        emit(FavLoaded(images: updatedList));
      } else {
          print("Image with id: $id not found with either approach.");
          emit(FavError(error: "Image not found"));
        }

    } catch (e) {
      print("Error in removeFromFavorites: $e");
      emit(FavError(error: e.toString()));
    }
  }
  Future<void> removeAll() async {
    try {
      final box = Hive.box<ImageModel>('FavImages');
      await box.clear();
      allImages = [];
      emit(FavLoaded(images: allImages));
    } catch (e) {
      emit(FavError(error: e.toString()));
    }
  }
}