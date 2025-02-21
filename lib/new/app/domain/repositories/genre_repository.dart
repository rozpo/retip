import '../entities/genre_entity.dart';

abstract class GenreRepository {
  Future<void> scan();

  Stream<List<GenreEntity>> allStream();

  Stream<GenreEntity?> byIdStream(int id);
}
