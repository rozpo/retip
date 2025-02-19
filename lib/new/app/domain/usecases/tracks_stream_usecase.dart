import '../entities/track_entity.dart';
import '../repositories/library_repository.dart';

class TracksStreamUsecase {
  final LibraryRepository _libraryRepository;

  TracksStreamUsecase({
    required LibraryRepository libraryRepository,
  }) : _libraryRepository = libraryRepository;

  Stream<List<TrackEntity>> call() {
    return _libraryRepository.tracksStream();
  }
}
