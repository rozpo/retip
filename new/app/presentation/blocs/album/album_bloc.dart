import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
    on<AlbumRefreshTracksEvent>(_onRefreshTracks);

    _tracksStream = _albumService.watchAlbumTracks(albumId).listen((tracks) {
      add(AlbumRefreshTracksEvent(tracks));
    });
  }

  StreamSubscription<List<TrackEntity>>? _tracksStream;

  @override
  Future<void> close() {
    _tracksStream?.cancel();

    return super.close();
  }

  void _onRefreshTracks(
    AlbumRefreshTracksEvent event,
    Emitter<AlbumState> emit,
  ) {
    emit(AlbumLoadedState(
      event.tracks,
    ));
  }
}
