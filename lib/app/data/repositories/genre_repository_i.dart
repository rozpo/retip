import '../../../objectbox.g.dart';
import '../../domain/entities/genre_entity.dart';
import '../../domain/repositories/genre_repository.dart';
import '../models/genre_model.dart';
import '../providers/objectbox_provider.dart';

class GenreRepositoryI implements GenreRepository {
  final ObjectboxProvider _objectboxProvider;

  GenreRepositoryI({
    required ObjectboxProvider objectboxProvider,
  }) : _objectboxProvider = objectboxProvider;

  @override
  Stream<GenreEntity?> genreStream(int id) {
    return _objectboxProvider
        .streamFirst<GenreModel>(GenreModel_.id.equals(id));
  }

  @override
  Stream<List<GenreEntity>> stream() {
    return _objectboxProvider.stream<GenreModel>();
  }

  @override
  void toggleFavorite(GenreEntity genre) async {
    final entity = await _objectboxProvider.get<GenreModel>(genre.id);

    if (entity == null) return;

    entity.isFavorite = !entity.isFavorite;
    _objectboxProvider.update(entity);
  }
}
