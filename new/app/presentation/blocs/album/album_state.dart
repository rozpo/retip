part of 'album_bloc.dart';

@immutable
sealed class AlbumState {}

final class AlbumInitialState extends AlbumState {}

final class AlbumLoadedState extends AlbumState {
  final List<TrackEntity> tracks;
  final AlbumEntity album;

  AlbumLoadedState({
    required this.tracks,
    required this.album,
  });

  AlbumLoadedState copyWith({
    List<TrackEntity>? tracks,
    AlbumEntity? album,
  }) {
    return AlbumLoadedState(
      tracks: tracks ?? this.tracks,
      album: album ?? this.album,
    );
  }
}
