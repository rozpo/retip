part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchIdleState extends SearchState {}

final class SearchSearchingState extends SearchState {}

final class SearchSuccessState extends SearchState {
  final List<ArtistEntity> artists;
  final List<AlbumEntity> albums;
  final List<TrackEntity> tracks;

  int get mediaLength => artists.length + albums.length + tracks.length;

  List<AbstractEntity> get media => [...artists, ...albums, ...tracks];

  SearchSuccessState({
    this.artists = const [],
    this.albums = const [],
    this.tracks = const [],
  });
}

final class SearchErrorState extends SearchState {}
