import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/track_entity.dart';
import '../../../domain/repositories/audio_repository.dart';
import '../../../domain/repositories/track_repository.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  final TrackRepository _trackRepository;
  final AudioRepository _audioRepository;

  TrackBloc({
    required TrackRepository trackRepository,
    required AudioRepository audioRepository,
  })  : _trackRepository = trackRepository,
        _audioRepository = audioRepository,
        super(TrackInitial(const [])) {
    on<TrackRefresh>(_onTrackRefresh);
    on<TrackPlay>(_onTrackPlay);

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

  void _onTrackPlay(TrackPlay event, Emitter<TrackState> emit) {
    _audioRepository.play(event.tracks, event.index);
  }
}
