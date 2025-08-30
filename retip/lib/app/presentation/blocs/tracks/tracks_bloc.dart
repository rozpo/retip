import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/domain/entities/track_entity.dart';
import 'package:retip/app/domain/errors/result.dart';

import '../../../domain/repositories/track_repository.dart';

part 'tracks_event.dart';
part 'tracks_state.dart';

class TracksBloc extends Bloc<TracksEvent, TracksState> {
  StreamSubscription<List<TrackEntity>>? _stream;
  final TrackRepository _trackRepository;

  TracksBloc({required TrackRepository trackRepository})
    : _trackRepository = trackRepository,
      super(TracksState([])) {
    on<TracksScanEvent>(_scan);
    on<TracksRefreshEvent>(_refresh);

    final result = _trackRepository.streamAll();

    if (result is ResultSuccess<Stream<List<TrackEntity>>>) {
      _stream ??= result.data.listen((tracks) {
        add(TracksRefreshEvent(tracks));
      });
    }

    add(const TracksScanEvent());
  }

  @override
  Future<void> close() {
    _stream?.cancel();
    return super.close();
  }

  void _scan(TracksScanEvent event, Emitter<TracksState> emit) {
    _trackRepository.scan();
  }

  void _refresh(TracksRefreshEvent event, Emitter<TracksState> emit) {
    emit(TracksState(event.tracks));
  }
}
