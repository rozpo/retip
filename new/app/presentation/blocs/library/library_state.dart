part of 'library_bloc.dart';

@immutable
class LibraryState {
  final List<TrackEntity> tracks;

  const LibraryState({this.tracks = const []});

  LibraryState copyWith({
    List<TrackEntity>? tracks,
  }) {
    return LibraryState(
      tracks: tracks ?? this.tracks,
    );
  }
}
