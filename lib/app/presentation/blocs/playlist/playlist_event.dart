part of 'playlist_bloc.dart';

@immutable
sealed class PlaylistEvent {}

class PlaylistRefresh extends PlaylistEvent {
  final List<PlaylistEntity> playlists;

  PlaylistRefresh(this.playlists);
}

class PlaylistToggleFavorite extends PlaylistEvent {
  final PlaylistEntity playlist;

  PlaylistToggleFavorite(this.playlist);
}

class PlaylistCreate extends PlaylistEvent {}

class PlaylistRemove extends PlaylistEvent {
  final int playlistId;

  PlaylistRemove(this.playlistId);
}

class PlaylistAddTrack extends PlaylistEvent {
  final int playlistId;
  final int trackId;

  PlaylistAddTrack(this.playlistId, this.trackId);
}
