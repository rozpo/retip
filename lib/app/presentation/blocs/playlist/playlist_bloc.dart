import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
}
