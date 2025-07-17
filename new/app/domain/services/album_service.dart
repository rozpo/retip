import '../../data/repositories/track_repository.dart';
import '../entites/track_entity.dart';

interface class AlbumService {
  final TrackRepository _trackRepository;

  const AlbumService({
    required TrackRepository trackRepository,
  }) : _trackRepository = trackRepository;

  Stream<List<TrackEntity>> watchAlbumTracks(int albumId) {
    return _trackRepository.watchAlbumTracks(albumId);
  }
}
