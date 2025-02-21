import '../repositories/library_repository.dart';
import '../repositories/track_repository.dart';

class ScanLibraryUsecase {
  final LibraryRepository _libraryRepository;
  final TrackRepository _trackRepository;

  ScanLibraryUsecase({
    required LibraryRepository libraryRepository,
    required TrackRepository trackRepository,
  })  : _libraryRepository = libraryRepository,
        _trackRepository = trackRepository;

  Future<void> call() async {
    await _libraryRepository.scan();
    await _trackRepository.scan();
  }
}
