import '../../data/repositories/album_repository.dart';
import '../../data/repositories/track_repository.dart';
import '../entites/album_entity.dart';
import '../entites/track_entity.dart';

interface class LibraryService {
  final AlbumRepository _albumRepository;
  final TrackRepository _trackRepository;

  const LibraryService({
    required AlbumRepository albumRepository,
    required TrackRepository trackRepository,
  })  : _albumRepository = albumRepository,
        _trackRepository = trackRepository;

  Future<int> scan() async {
    final futures = await Future.wait<int>([
      _trackRepository.cacheAll(),
      _albumRepository.cacheAll(),
    ]);

    return futures.reduce((value, element) => value + element);
  }

  Stream<List<AlbumEntity>> watchAlbums() {
    return _albumRepository.watchAll();
  }

  Stream<List<TrackEntity>> watchTracks() {
    return _trackRepository.watchAll();
  }
}
