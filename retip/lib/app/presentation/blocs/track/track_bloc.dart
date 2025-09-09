import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/track_repository.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  final TrackRepository _trackRepository;

  TrackBloc(this._trackRepository) : super(TrackInitState()) {
    on<TrackFetchAllEvent>(_onFetchAll);
    on<TrackFetchByAlbumEvent>(_onFetchByAlbum);
  }

  void _onFetchAll(TrackFetchAllEvent event, Emitter<TrackState> emit) async {
    final result = await _trackRepository.getAll();

    if (result is ResultSuccess<List<TrackEntity>>) {
      emit(TrackIdleState(result.data));
    }
  }

  void _onFetchByAlbum(
    TrackFetchByAlbumEvent event,
    Emitter<TrackState> emit,
  ) async {
    final result = await _trackRepository.getByAlbum(event.id);

    if (result is ResultSuccess<List<TrackEntity>>) {
      emit(TrackIdleState(result.data));
    }
  }
}
