import '../repositories/library_repository.dart';

class ScanLibraryUsecase {
  final LibraryRepository _libraryRepository;

  ScanLibraryUsecase({
    required LibraryRepository libraryRepository,
  }) : _libraryRepository = libraryRepository;

  Future<void> call() async {
    await _libraryRepository.scan();
  }
}
