part of 'favourites_bloc.dart';

@immutable
class FavouritesState {
  final List<TrackEntity> tracks;
  final bool isLoading;
  final String title;

  const FavouritesState({
    this.tracks = const [],
    this.isLoading = false,
    this.title = '',
  });

  FavouritesState copyWith({
    List<TrackEntity>? tracks,
    bool? isLoading,
    String? title,
  }) {
    return FavouritesState(
      isLoading: isLoading ?? this.isLoading,
      tracks: tracks ?? this.tracks,
      title: title ?? this.title,
    );
  }
}
