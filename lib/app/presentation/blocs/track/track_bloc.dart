import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/track_entity.dart';
import '../../../domain/repositories/track_repository.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  final TrackRepository _trackRepository;

  TrackBloc({
    required TrackRepository trackRepository,
  })  : _trackRepository = trackRepository,
        super(TrackInitial(const [])) {
    on<TrackRefresh>(_onTrackRefresh);

    _subscription = _trackRepository.stream().listen((tracks) {
      add(TrackRefresh(tracks));
    });
  }

  StreamSubscription? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void _onTrackRefresh(TrackRefresh event, Emitter<TrackState> emit) {
    emit(TrackInitial(event.tracks));
  }
}
