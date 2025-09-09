part of 'album_bloc.dart';

@immutable
sealed class AlbumEvent {
  const AlbumEvent();
}

final class AlbumFetchAllEvent extends AlbumEvent {
  const AlbumFetchAllEvent();
}

final class AlbumFetchByArtistEvent extends AlbumEvent {
  final int id;

  const AlbumFetchByArtistEvent(this.id);
}
