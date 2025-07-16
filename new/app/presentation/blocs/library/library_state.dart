part of 'library_bloc.dart';

@immutable
sealed class LibraryState {
  final List<ArtistEntity> artists;
  final List<AlbumEntity> albums;
  final List<GenreEntity> genres;
  final List<TrackEntity> tracks;

  const LibraryState({
    this.artists = const [],
    this.albums = const [],
    this.genres = const [],
    this.tracks = const [],
  });
}

class LibraryIdleState extends LibraryState {
  const LibraryIdleState();
}

class LibraryLoadedState extends LibraryState {
  const LibraryLoadedState({
    super.artists = const [],
    super.albums = const [],
    super.genres = const [],
    super.tracks = const [],
  });

  LibraryLoadedState copyWith({
    List<ArtistEntity>? artists,
    List<AlbumEntity>? albums,
    List<GenreEntity>? genres,
    List<TrackEntity>? tracks,
  }) {
    return LibraryLoadedState(
      artists: artists ?? this.artists,
      albums: albums ?? this.albums,
      genres: genres ?? this.genres,
      tracks: tracks ?? this.tracks,
    );
  }
}
