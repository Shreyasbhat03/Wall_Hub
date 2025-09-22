part of 'fav_cubit.dart';

@immutable
sealed class FavState {}
final class FavInitial extends FavState {}

final class FavLoading extends FavState {}

final class FavLoaded extends FavState {
  final List<ImageModel> images;
  FavLoaded({required this.images});
}
final class FavError extends FavState {
  final String error;
  FavError({required this.error});
}
