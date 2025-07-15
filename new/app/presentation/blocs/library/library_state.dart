part of 'library_bloc.dart';

@immutable
sealed class LibraryState {
  const LibraryState();
}

class LibraryIdleState extends LibraryState {
  const LibraryIdleState();
}

class LibraryLoadedState extends LibraryState {
  final List<TrackEntity> tracks;

  const LibraryLoadedState({this.tracks = const []});

  LibraryLoadedState copyWith({
    List<TrackEntity>? tracks,
  }) {
    return LibraryLoadedState(
      tracks: tracks ?? this.tracks,
    );
  }
}
