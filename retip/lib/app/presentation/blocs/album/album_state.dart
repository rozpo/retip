part of 'album_bloc.dart';

@immutable
sealed class AlbumState {
  const AlbumState();
}

final class AlbumInitState extends AlbumState {}

final class AlbumIdleState extends AlbumState {
  final List<AlbumEntity> albums;

  const AlbumIdleState([this.albums = const []]);
}

final class AlbumErrorState extends AlbumState {
  final Exception error;

  const AlbumErrorState(this.error);
}
