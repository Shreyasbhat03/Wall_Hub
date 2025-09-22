import'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wallpaper_app/Hive_Repo/data_model.dart';
import 'package:wallpaper_app/bloc/wallhub_event.dart';
import 'package:wallpaper_app/bloc/wallhub_state.dart';
import '../apiCall/imageFetch.dart';
class wallhubBloc extends Bloc<WallhubEvent,wallhubState>{
  wallhubBloc():super(wallhubInitialState()){
    List<ImageModel> allImages=[];
    on<wallhubLoadEvent>((event, emit) async {
      emit(wallhubLoadingState());
      try {
        // This should return List<ImageModel> directly from your fetchImages function
        final List<ImageModel> data = await fetchImages(event.url!);
        allImages = data;

        // Check which images are already liked in Hive
        final box = Hive.box<ImageModel>('FavImages');
        List<bool> likedList = allImages.map((image) {
          return box.values.any((likedImage) => likedImage.id == image.id);
        }).toList();

        emit(wallhubLoadedState(images: allImages, isliked: likedList));
      } catch(e) {
        emit(wallhubErrorState(error: e.toString()));
      }
    });

    on<wallhubReloadEvent>((event, emit) async {
      try {
        // Load more images
        final List<ImageModel> data = await fetchImages(event.url!);
        allImages = [...allImages, ...data];

        // Check liked status for all images
        final box = Hive.box<ImageModel>('FavImages');
        List<bool> likedList = allImages.map((image) {
          return box.values.any((likedImage) => likedImage.id == image.id);
        }).toList();

        emit(wallhubLoadedState(images: allImages, isliked: likedList));
      } catch(e) {
        emit(wallhubErrorState(error: e.toString()));
      }
    });

    on<ToggelLikeEvent>((event, emit) async {
      if (state is wallhubLoadedState) {
        final currentState = state as wallhubLoadedState;

        // Clone like list and toggle the value
        List<bool> updatedLike = List.from(currentState.isliked);
        updatedLike[event.index] = !updatedLike[event.index];

        // Get the image being toggled
        final imageData = currentState.images[event.index];
        final box = Hive.box<ImageModel>('FavImages');

        if (updatedLike[event.index]) {
          final model = ImageModel(
            id: imageData.id,
            imageUrlLarge: imageData.imageUrlLarge,
            imageUrlMedium: imageData.imageUrlMedium,
            isLiked: true,
            photographer: imageData.photographer,
            photoName: imageData.photoName,
            dateTime: DateTime.now(), // Current timestamp when liked
          );

          // Check if it already exists to avoid duplicates
          final alreadyExists = box.values.any((img) => img.id == model.id);
          if (!alreadyExists) {
            await box.put(model.id,model);
          }
        } else {
          // ❌ If image is unliked — remove from Hive
          final keyToRemove = box.keys.firstWhere(
                (key) => box.get(key)?.id == imageData.id,
            orElse: () => null,
          );
          if (keyToRemove != null) {
            await box.delete(imageData.id);
          }
        }
    print("Image ${updatedLike[event.index] ? 'liked' : 'unliked'}: ${imageData.id} with date ${imageData.dateTime}");
        // Emit updated state
        emit(wallhubLoadedState(images: currentState.images, isliked: updatedLike));
      }
    });

    on<wallhubSearchEvent>((event,emit) async{
      emit(wallhubLoadingState());
      try{
       add(wallhubLoadEvent(url: "https://api.pexels.com/v1/search?query=${event.query}&per_page=50"));

      }catch(e){
        emit(wallhubErrorState(error:e.toString()));
      }
    });
  }

  Future<void> close() async {
    print("Bloc closed");
    await super.close();
  }

}

