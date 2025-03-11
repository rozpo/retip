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
