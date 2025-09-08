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
    on<AlbumRefreshEvent>(_onRefresh);

    _albumRepository.getAll().then((result) {
      if (result is ResultSuccess<List<AlbumEntity>>) {
        add(AlbumRefreshEvent(result.data));
      }
    });
  }

  void _onRefresh(AlbumRefreshEvent event, Emitter<AlbumState> emit) {
    emit(AlbumIdleState(event.albums));
  }
}
