abstract class wallhubState {
}
class wallhubInitialState extends wallhubState {
}
class wallhubLoadingState extends wallhubState {
}
class wallhubLoadedState extends wallhubState {
  final List images;
  final List<bool> isliked;
  wallhubLoadedState({required this.images,required this.isliked});
}
class wallhubErrorState extends wallhubState {
  final String error;
  wallhubErrorState({required this.error});
}
