part of 'album_bloc.dart';

@immutable
sealed class AlbumEvent {
  const AlbumEvent();
}

final class AlbumRefreshEvent extends AlbumEvent {
  final List<AlbumEntity> albums;

  const AlbumRefreshEvent(this.albums);
}
