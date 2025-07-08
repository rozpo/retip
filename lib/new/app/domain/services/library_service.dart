import '../../data/repositories/track_repository.dart';
import '../entities/track_entity.dart';

interface class LibraryService {
  final TrackRepository _trackRepository;

  const LibraryService({
    required TrackRepository trackRepository,
  }) : _trackRepository = trackRepository;

  Future<int> scan() async {
    final results = await Future.wait([
      _trackRepository.scan(),
    ]);

    return results.reduce((value, element) => value + element);
  }

  Stream<List<TrackEntity>> tracksStream() {
    return _trackRepository.watchAll();
  }
}
