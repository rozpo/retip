import '../../data/repositories/album_repository.dart';
import '../../data/repositories/track_repository.dart';
import '../entites/album_entity.dart';
import '../entites/track_entity.dart';

interface class AlbumService {
  final AlbumRepository _albumRepository;
  final TrackRepository _trackRepository;

  const AlbumService({
    required AlbumRepository albumRepository,
    required TrackRepository trackRepository,
  })  : _albumRepository = albumRepository,
        _trackRepository = trackRepository;

  Stream<AlbumEntity> watchAlbum(int albumId) {
    return _albumRepository.watchById(albumId);
  }

  Stream<List<TrackEntity>> watchAlbumTracks(int albumId) {
    return _trackRepository.watchByAlbum(albumId);
  }
}
