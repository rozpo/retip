import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/album_entity.dart';
import '../../../domain/repositories/album_repository.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository _albumRepository;

  AlbumBloc({
    required AlbumRepository albumRepository,
  })  : _albumRepository = albumRepository,
        super(AlbumInitial(const [])) {
    on<AlbumRefresh>(_onAlbumRefresh);
    on<AlbumToggleFavorite>(_onAlbumToggleFavorite);

    _subscription = _albumRepository.stream().listen((albums) {
      add(AlbumRefresh(albums));
    });
  }

  StreamSubscription? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void _onAlbumRefresh(AlbumRefresh event, Emitter<AlbumState> emit) {
    emit(AlbumInitial(event.albums));
  }

  void _onAlbumToggleFavorite(
      AlbumToggleFavorite event, Emitter<AlbumState> emit) {
    _albumRepository.toggleFavorite(event.album);
  }
}
