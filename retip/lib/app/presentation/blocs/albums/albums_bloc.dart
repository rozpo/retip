import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/domain/entities/album_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/album_repository.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  StreamSubscription<List<AlbumEntity>>? _stream;
  final AlbumRepository _albumRepository;

  AlbumsBloc({required AlbumRepository albumRepository})
    : _albumRepository = albumRepository,
      super(AlbumsState([])) {
    on<AlbumsScanEvent>(_onAlbumsScanEvent);
    on<AlbumsRefreshEvent>(_onAlbumsRefreshEvent);

    final result = _albumRepository.streamAll();

    if (result is ResultSuccess<Stream<List<AlbumEntity>>>) {
      _stream ??= result.data.listen((albums) {
        add(AlbumsRefreshEvent(albums));
      });
    }

    add(const AlbumsScanEvent());
  }

  @override
  Future<void> close() {
    _stream?.cancel();
    return super.close();
  }

  void _onAlbumsScanEvent(
    AlbumsScanEvent event,
    Emitter<AlbumsState> emit,
  ) async {
    _albumRepository.scan();
  }

  void _onAlbumsRefreshEvent(
    AlbumsRefreshEvent event,
    Emitter<AlbumsState> emit,
  ) async {
    emit(AlbumsState(event.albums));
  }
}
