import '../../data/repositories/track_repository.dart';
import '../entites/track_entity.dart';

interface class LibraryService {
  final TrackRepository _trackRepository;

  const LibraryService({
    required TrackRepository trackRepository,
  }) : _trackRepository = trackRepository;

  Future<int> scan() async {
    final tracksLength = _trackRepository.cacheAll();

    return tracksLength;
  }

  Stream<List<TrackEntity>> watchTracks() {
    return _trackRepository.watchAll();
  }
}
