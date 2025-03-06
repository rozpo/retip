import '../../../../../../../last/app/domain/entities/genre_entity.dart';
import '../repositories/genre_repository.dart';

class GenreUsecase {
  final GenreRepository _genreRepository;

  const GenreUsecase({
    required GenreRepository genreRepository,
  }) : _genreRepository = genreRepository;

  Stream<List<GenreEntity>> allStream() {
    return _genreRepository.allStream();
  }

  Stream<GenreEntity?> byIdStream(int id) {
    return _genreRepository.byIdStream(id);
  }
}
