import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entites/track_entity.dart';
import '../../../domain/services/audio_service.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioService _audioService;

  AudioBloc({
    required AudioService audioService,
  })  : _audioService = audioService,
        super(AudioInitial()) {
    on<AudioLoadPlaylistEvent>(_onLoadPlaylist);
    on<AudioPlayEvent>(_onPlay);
  }

  void _onLoadPlaylist(
    AudioLoadPlaylistEvent event,
    Emitter<AudioState> emit,
  ) async {
    await _audioService.loadPlaylist(event.tracks, event.index);

    if (event.autoplay) {
      _audioService.play();
    }
  }

  void _onPlay(
    AudioPlayEvent event,
    Emitter<AudioState> emit,
  ) {
    _audioService.play();
  }
}
