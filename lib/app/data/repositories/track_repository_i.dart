import '../../../objectbox.g.dart';
import '../../domain/entities/track_entity.dart';
import '../../domain/repositories/track_repository.dart';
import '../models/track_model.dart';
import '../providers/objectbox_provider.dart';

class TrackRepositoryI implements TrackRepository {
  final ObjectboxProvider _objectboxProvider;

  TrackRepositoryI({
    required ObjectboxProvider objectboxProvider,
  }) : _objectboxProvider = objectboxProvider;

  @override
  Stream<List<TrackEntity>> streamAll() {
    return _objectboxProvider.stream<TrackModel>();
  }

  @override
  void toggleFavorite(TrackEntity track) async {
    final entity = await _objectboxProvider.get<TrackModel>(track.id);

    if (entity == null) return;

    entity.isFavorite = !entity.isFavorite;
    _objectboxProvider.update(entity);
  }

  @override
  Stream<TrackEntity?> trackStream(int id) {
    return _objectboxProvider
        .streamFirst<TrackModel>(TrackModel_.id.equals(id));
  }

  @override
  Stream<List<TrackEntity>> streamByAlbum(int albumId) {
    return _objectboxProvider.stream<TrackModel>(
      TrackModel_.albumDb.equals(albumId),
    );
  }

  @override
  Stream<List<TrackEntity>> streamByArtist(int artistId) {
    return _objectboxProvider.stream<TrackModel>(
      TrackModel_.artistDb.equals(artistId),
    );
  }

  @override
  Stream<List<TrackEntity>> streamByGenre(int genreId) {
    return _objectboxProvider.stream<TrackModel>(
      TrackModel_.genreDb.equals(genreId),
    );
  }
}
