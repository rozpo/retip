import '../entities/genre_entity.dart';

abstract class GenreRepository {
  Stream<List<GenreEntity>> stream();

  void toggleFavorite(GenreEntity genre);

  Stream<GenreEntity?> genreStream(int id);
}
