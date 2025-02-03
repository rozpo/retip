part of 'search_bloc.dart';

@immutable
sealed class SearchState {
  final FocusNode focusNode = FocusNode();
}

final class SearchIdleState extends SearchState {}

final class SearchSearchingState extends SearchState {}

final class SearchSuccessState extends SearchState {
  final List<ArtistEntity> artists;
  final List<AlbumEntity> albums;
  final List<PlaylistEntity> playlists;
  final List<TrackEntity> tracks;

  final String query;

  int get mediaLength =>
      artists.length + albums.length + playlists.length + tracks.length;

  List<AbstractEntity> get media => [
        ...artists,
        ...albums,
        ...playlists,
        ...tracks,
      ];

  SearchSuccessState({
    this.artists = const [],
    this.albums = const [],
    this.playlists = const [],
    this.tracks = const [],
    this.query = '',
  });
}

final class SearchErrorState extends SearchState {}
