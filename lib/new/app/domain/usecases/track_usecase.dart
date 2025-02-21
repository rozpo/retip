import '../entities/track_entity.dart';
import '../repositories/track_repository.dart';

class TrackUsecase {
  final TrackRepository _trackRepository;

  const TrackUsecase({
    required TrackRepository trackRepository,
  }) : _trackRepository = trackRepository;

  Stream<List<TrackEntity>> allStream() {
    return _trackRepository.allStream();
  }

  Stream<List<TrackEntity>> byAlbumStream(int albumId) {
    return _trackRepository.byAlbumStream(albumId);
  }

  Stream<List<TrackEntity>> byArtistStream(int artistId) {
    return _trackRepository.byArtistStream(artistId);
  }
}
