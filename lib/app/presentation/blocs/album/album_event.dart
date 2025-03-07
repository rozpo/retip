part of 'album_bloc.dart';

@immutable
sealed class AlbumEvent {}

final class AlbumRefresh extends AlbumEvent {
  final List<AlbumEntity> albums;

  AlbumRefresh(this.albums);
}

final class AlbumToggleFavorite extends AlbumEvent {
  final AlbumEntity album;

  AlbumToggleFavorite(this.album);
}
