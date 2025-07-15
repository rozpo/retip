part of 'library_bloc.dart';

@immutable
sealed class LibraryState {
  final List<AlbumEntity> albums;
  final List<TrackEntity> tracks;

  const LibraryState({
    this.albums = const [],
    this.tracks = const [],
  });
}

class LibraryIdleState extends LibraryState {
  const LibraryIdleState({
    super.albums = const [],
    super.tracks = const [],
  });
}

class LibraryLoadedState extends LibraryState {
  const LibraryLoadedState({
    super.albums = const [],
    super.tracks = const [],
  });

  LibraryLoadedState copyWith({
    List<AlbumEntity>? albums,
    List<TrackEntity>? tracks,
  }) {
    return LibraryLoadedState(
      albums: albums ?? this.albums,
      tracks: tracks ?? this.tracks,
    );
  }
}
