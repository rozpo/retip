import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/domain/services/audio_service.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioService _audioService;

  AudioBloc(this._audioService) : super(AudioInitState()) {
    on<AudioInitializeEvent>((event, emit) async {
      await emit.forEach(
        _audioService.indexStream(),
        onData: (data) {
          return data != null ? AudioIdleState(data) : AudioIdleState(-1);
        },
        onError: (error, stackTrace) => AudioIdleState(-1),
      );
    });
  }
}
