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

  @override
  Future<void> resume() async {
    await _justAudioProvider.resume();
  }

  @override
  Stream<Duration> get duration => _justAudioProvider.duration;

  @override
  Stream<int> get index => _justAudioProvider.index;

  @override
  Stream<bool> get isPlaying => _justAudioProvider.isPlaying;

  @override
  Stream<Duration> get position => _justAudioProvider.position;

  @override
  Future<void> next() async {
    await _justAudioProvider.next();
  }

  @override
  Future<void> previous() async {
    await _justAudioProvider.previous();
  }
}
