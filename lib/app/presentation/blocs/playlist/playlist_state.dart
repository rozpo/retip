part of 'playlist_bloc.dart';

@immutable
sealed class PlaylistState {}

final class PlaylistInitial extends PlaylistState {
  final List<PlaylistEntity> playlists;

  PlaylistInitial(this.playlists);
}
