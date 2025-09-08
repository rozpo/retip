import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/track_repository.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  final TrackRepository _trackRepository;

  TrackBloc(this._trackRepository) : super(TrackIdleState()) {
    on<TrackRefreshEvent>(_onRefresh);
    _trackRepository.getAll().then((result) {
      if (result is ResultSuccess<List<TrackEntity>>) {
        add(TrackRefreshEvent(result.data));
      }
    });
  }

  void _onRefresh(TrackRefreshEvent event, Emitter<TrackState> emit) {
    emit(TrackIdleState(event.tracks));
  }
}
