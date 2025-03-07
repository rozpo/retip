import '../../domain/entities/track_entity.dart';
import '../../domain/repositories/audio_repository.dart';
import '../providers/just_audio_provider.dart';

class AudioRepositoryI implements AudioRepository {
  final JustAudioProvider _justAudioProvider;

  AudioRepositoryI({
    required JustAudioProvider justAudioProvider,
  }) : _justAudioProvider = justAudioProvider;

  @override
  Future<void> pause() async {
    await _justAudioProvider.pause();
  }

  @override
  Future<void> play(List<TrackEntity> tracks, int index) async {
    await _justAudioProvider.play(tracks, index);
  }
}
