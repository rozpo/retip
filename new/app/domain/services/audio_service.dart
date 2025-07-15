import '../../data/repositories/audio_repository.dart';
import '../entites/track_entity.dart';

interface class AudioService {
  final AudioRepository _audioRepository;

  const AudioService({
    required AudioRepository audioRepository,
  }) : _audioRepository = audioRepository;

  Future<void> loadPlaylist(List<TrackEntity> tracks, [int? index]) async {
    return await _audioRepository.loadPlaylist(tracks, index);
  }

  Future<void> play() async {
    return await _audioRepository.play();
  }
}
