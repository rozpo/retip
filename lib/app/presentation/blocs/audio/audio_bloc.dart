import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/track_entity.dart';
import '../../../domain/repositories/audio_repository.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioRepository _audioRepository;

  AudioBloc({
    required AudioRepository audioRepository,
  })  : _audioRepository = audioRepository,
        super(AudioState.initial()) {
    on<AudioPlay>(_onAudioPlay);
    on<AudioPause>(_onAudioPause);
    on<AudioResume>(_onAudioResume);
    on<AudioIndexChanged>(_onAudioIndexChanged);
    on<AudioIsPlayingChanged>(_onAudioIsPlayingChanged);
    on<AudioPositionChanged>(_onAudioPositionChanged);
    on<AudioDurationChanged>(_onAudioDurationChanged);
    on<AudioNext>(_onAudioNext);
    on<AudioPrevious>(_onAudioPrevious);

    _indexSubscription = _audioRepository.index.listen((index) {
      add(AudioIndexChanged(index));
    });

    _isPlayingSubscription = _audioRepository.isPlaying.listen((isPlaying) {
      add(AudioIsPlayingChanged(isPlaying));
    });

    _positionSubscription = _audioRepository.position.listen((position) {
      add(AudioPositionChanged(position));
    });

    _durationSubscription = _audioRepository.duration.listen((duration) {
      add(AudioDurationChanged(duration));
    });
  }

  StreamSubscription? _indexSubscription;
  StreamSubscription? _isPlayingSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;

  @override
  Future<void> close() {
    _indexSubscription?.cancel();
    _isPlayingSubscription?.cancel();
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    return super.close();
  }

  void _onAudioPlay(AudioPlay event, Emitter<AudioState> emit) {
    _audioRepository.play(event.tracks, event.index);
    emit(state.copyWith(playlist: event.tracks));
  }

  void _onAudioPause(AudioPause event, Emitter<AudioState> emit) {
    _audioRepository.pause();
  }

  void _onAudioNext(AudioNext event, Emitter<AudioState> emit) {
    _audioRepository.next();
  }

  void _onAudioPrevious(AudioPrevious event, Emitter<AudioState> emit) {
    _audioRepository.previous();
  }

  void _onAudioIndexChanged(AudioIndexChanged event, Emitter<AudioState> emit) {
    emit(state.copyWith(index: event.index));
  }

  void _onAudioIsPlayingChanged(
      AudioIsPlayingChanged event, Emitter<AudioState> emit) {
    emit(state.copyWith(isPlaying: event.isPlaying));
  }

  void _onAudioPositionChanged(
      AudioPositionChanged event, Emitter<AudioState> emit) {
    emit(state.copyWith(position: event.position));
  }

  void _onAudioDurationChanged(
      AudioDurationChanged event, Emitter<AudioState> emit) {
    emit(state.copyWith(duration: event.duration));
  }

  void _onAudioResume(AudioResume event, Emitter<AudioState> emit) {
    _audioRepository.resume();
  }
}
