import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entites/album_entity.dart';
import '../../../domain/entites/track_entity.dart';
import '../../../domain/services/album_service.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final int albumId;
  final AlbumService _albumService;

  AlbumBloc({
    required AlbumService albumService,
    required this.albumId,
  })  : _albumService = albumService,
        super(AlbumInitialState()) {
    on<AlbumRefreshAlbumEvent>(_onRefreshAlbum);
    on<AlbumRefreshTracksEvent>(_onRefreshTracks);

    _albumStream = _albumService.watchAlbum(albumId).listen((album) {
      add(AlbumRefreshAlbumEvent(album));
    });
  }

  StreamSubscription<AlbumEntity>? _albumStream;
  StreamSubscription<List<TrackEntity>>? _tracksStream;

  @override
  Future<void> close() {
    _albumStream?.cancel();
    _tracksStream?.cancel();

    return super.close();
  }

  void _onRefreshAlbum(
    AlbumRefreshAlbumEvent event,
    Emitter<AlbumState> emit,
  ) {
    if (state is AlbumLoadedState) {
      final loadedState = state as AlbumLoadedState;

      emit(loadedState.copyWith(album: event.album));
    } else {
      emit(AlbumLoadedState(tracks: const [], album: event.album));

      _tracksStream = _albumService.watchAlbumTracks(albumId).listen((tracks) {
        add(AlbumRefreshTracksEvent(tracks));
      });
    }
  }

  void _onRefreshTracks(
    AlbumRefreshTracksEvent event,
    Emitter<AlbumState> emit,
  ) {
    if (state is AlbumLoadedState) {
      final loadedState = state as AlbumLoadedState;

      emit(loadedState.copyWith(tracks: event.tracks));
    }
  }
}
