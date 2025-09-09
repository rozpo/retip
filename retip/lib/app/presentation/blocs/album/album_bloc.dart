import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/domain/enitities/album_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/album_repository.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository _albumRepository;

  AlbumBloc(this._albumRepository) : super(AlbumIdleState()) {
    on<AlbumFetchAllEvent>(_onFetchAll);
    on<AlbumFetchByArtistEvent>(_onFetchByArtist);
  }

  void _onFetchAll(AlbumFetchAllEvent event, Emitter<AlbumState> emit) async {
    final result = await _albumRepository.getAll();

    if (result is ResultSuccess<List<AlbumEntity>>) {
      emit(AlbumIdleState(result.data));
    }
  }

  void _onFetchByArtist(
    AlbumFetchByArtistEvent event,
    Emitter<AlbumState> emit,
  ) async {
    final result = await _albumRepository.getByArtist(event.id);

    if (result is ResultSuccess<List<AlbumEntity>>) {
      emit(AlbumIdleState(result.data));
    }
  }
}
