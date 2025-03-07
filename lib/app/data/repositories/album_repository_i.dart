import '../../../objectbox.g.dart';
import '../../domain/entities/album_entity.dart';
import '../../domain/repositories/album_repository.dart';
import '../models/album_model.dart';
import '../providers/objectbox_provider.dart';

class AlbumRepositoryI implements AlbumRepository {
  final ObjectboxProvider _objectboxProvider;

  AlbumRepositoryI({
    required ObjectboxProvider objectboxProvider,
  }) : _objectboxProvider = objectboxProvider;

  @override
  Stream<List<AlbumEntity>> stream() {
    return _objectboxProvider.stream<AlbumModel>();
  }

  @override
  void toggleFavorite(AlbumEntity album) async {
    final entity = await _objectboxProvider.get<AlbumModel>(album.id);

    if (entity == null) return;

    entity.isFavorite = !entity.isFavorite;
    _objectboxProvider.update(entity);
  }

  @override
  Stream<AlbumEntity?> trackStream(int id) {
    return _objectboxProvider.streamOne<AlbumModel>(AlbumModel_.id.equals(id));
  }
}
