import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/playlist_entity.dart';
import '../../../domain/repositories/playlist_repository.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final PlaylistRepository _playlistRepository;
  StreamSubscription? _subscription;

  PlaylistBloc({
    required PlaylistRepository playlistRepository,
  })  : _playlistRepository = playlistRepository,
        super(PlaylistInitial(const [])) {
    on<PlaylistRefresh>(_onPlaylistRefresh);
    on<PlaylistToggleFavorite>(_onPlaylistToggleFavorite);
    on<PlaylistCreate>(_onPlaylistCreate);
    on<PlaylistRemove>(_onPlaylistRemove);
    on<PlaylistAddTrack>(_onPlaylistAddTrack);

    _subscription = _playlistRepository.stream().listen((playlists) {
      add(PlaylistRefresh(playlists));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void _onPlaylistRefresh(PlaylistRefresh event, Emitter<PlaylistState> emit) {
    emit(PlaylistInitial(event.playlists));
  }

  void _onPlaylistToggleFavorite(
      PlaylistToggleFavorite event, Emitter<PlaylistState> emit) {
    _playlistRepository.toggleFavorite(event.playlist);
  }

  void _onPlaylistCreate(PlaylistCreate event, Emitter<PlaylistState> emit) {
    _playlistRepository.create(const Uuid().v4());
  }

  void _onPlaylistRemove(PlaylistRemove event, Emitter<PlaylistState> emit) {
    _playlistRepository.delete(event.playlistId);
  }

  void _onPlaylistAddTrack(
      PlaylistAddTrack event, Emitter<PlaylistState> emit) {
    _playlistRepository.addTrack(event.playlistId, event.trackId);
  }
}
