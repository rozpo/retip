part of 'favourites_bloc.dart';

@immutable
class FavouritesState {
  final List<TrackEntity> tracks;
  final String title;

  const FavouritesState({
    this.tracks = const [],
    this.title = '',
  });

  FavouritesState copyWith({
    List<TrackEntity>? tracks,
    String? title,
  }) {
    return FavouritesState(
      tracks: tracks ?? this.tracks,
      title: title ?? this.title,
    );
  }
}
