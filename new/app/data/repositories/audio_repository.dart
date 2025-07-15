import '../../domain/entites/track_entity.dart';
import '../providers/just_audio_provider.dart';

interface class AudioRepository {
  final JustAudioProvider _justAudioProvider;

  const AudioRepository({
    required JustAudioProvider justAudioProvider,
  }) : _justAudioProvider = justAudioProvider;

  Future<void> loadPlaylist(List<TrackEntity> tracks, [int? index]) async {
    return await _justAudioProvider.loadPlaylist(tracks, index);
  }

  Future<void> play() async {
    return await _justAudioProvider.play();
  }
}
