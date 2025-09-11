import 'package:retip/app/data/providers/just_audio_provider.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/services/audio_service.dart';

final class AudioServiceI implements AudioService {
  final JustAudioProvider _justAudioProvider;

  const AudioServiceI(this._justAudioProvider);

  @override
  Future<Result<void>> load(List<TrackEntity> tracks, {int? index}) async {
    try {
      await _justAudioProvider.load(tracks, index: index);
      _justAudioProvider.play();

      return ResultSuccess<void>(null);
    } catch (e) {
      return ResultFailure.fromObject(e);
    }
  }

  @override
  Result<void> pause() {
    try {
      return ResultSuccess(_justAudioProvider.pause());
    } catch (e) {
      return ResultFailure.fromObject(e);
    }
  }

  @override
  Result<void> play() {
    try {
      return ResultSuccess(_justAudioProvider.play());
    } catch (e) {
      return ResultFailure.fromObject(e);
    }
  }
}
