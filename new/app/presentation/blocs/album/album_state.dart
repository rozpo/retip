part of 'album_bloc.dart';

@immutable
sealed class AlbumState {}

final class AlbumInitialState extends AlbumState {}

final class AlbumLoadedState extends AlbumState {
  final List<TrackEntity> tracks;

  AlbumLoadedState(this.tracks);
}
