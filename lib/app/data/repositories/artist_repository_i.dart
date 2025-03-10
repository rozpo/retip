import '../../../objectbox.g.dart';
import '../../domain/entities/artist_entity.dart';
import '../../domain/repositories/artist_repository.dart';
import '../models/artist_model.dart';
import '../providers/objectbox_provider.dart';

class ArtistRepositoryI implements ArtistRepository {
  final ObjectboxProvider _objectboxProvider;

  ArtistRepositoryI({
    required ObjectboxProvider objectboxProvider,
  }) : _objectboxProvider = objectboxProvider;

  @override
  Stream<ArtistEntity?> artistStream(int id) {
    return _objectboxProvider
        .streamOne<ArtistModel>(ArtistModel_.id.equals(id));
  }

  @override
  Stream<List<ArtistEntity>> stream() {
    return _objectboxProvider.stream<ArtistModel>();
  }

  @override
  void toggleFavorite(ArtistEntity artist) async {
    final entity = await _objectboxProvider.get<ArtistModel>(artist.id);

    if (entity == null) return;

    entity.isFavorite = !entity.isFavorite;
    _objectboxProvider.update(entity);
  }
}
