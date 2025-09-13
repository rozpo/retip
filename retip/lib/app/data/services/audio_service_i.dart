import 'package:retip/app/data/providers/just_audio_provider.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/services/audio_service.dart';

final class AudioServiceI implements AudioService {
  final JustAudioProvider _justAudioProvider;

  const AudioServiceI(this._justAudioProvider);

  @override
  Future<Result<void>> setQueue(List<TrackEntity> tracks, {int? index}) async {
    try {
      await _justAudioProvider.setAudioSources(tracks, index: index);
      _justAudioProvider.play();

      return ResultSuccess<void>(null);
    } catch (e) {
      return ResultFailure.fromObject(e);
    }
  }

  @override
  Future<Result<void>> addToQueue(List<TrackEntity> tracks) async {
    try {
      await _justAudioProvider.addAudioSources(tracks);

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

  @override
  Stream<int?> indexStream() {
    return _justAudioProvider.currentIndexStream;
  }

  @override
  Stream<Duration> durationStream() {
    return _justAudioProvider.durationStream.map((e) => e ?? Duration.zero);
  }

  @override
  Stream<Duration> positionStream() {
    return _justAudioProvider.positionStream;
  }
}
