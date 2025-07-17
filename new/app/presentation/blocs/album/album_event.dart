part of 'album_bloc.dart';

@immutable
sealed class AlbumEvent {
  const AlbumEvent();
}

final class AlbumRefreshTracksEvent extends AlbumEvent {
  final List<TrackEntity> tracks;

  const AlbumRefreshTracksEvent(this.tracks);
}
