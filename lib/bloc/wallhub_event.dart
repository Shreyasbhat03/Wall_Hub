abstract class WallhubEvent {}

class wallhubLoadEvent extends WallhubEvent {
  final String? url;
  wallhubLoadEvent({this.url});
}
class wallhubReloadEvent extends WallhubEvent {
  final String? url;
  wallhubReloadEvent({this.url});
}
class wallhubSearchEvent extends WallhubEvent {
  final String? query;
  wallhubSearchEvent({this.query});
}
class ToggelLikeEvent extends WallhubEvent {
  final int index;
  ToggelLikeEvent({required this.index});
}

