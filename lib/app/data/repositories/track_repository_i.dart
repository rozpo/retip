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
  Stream<List<TrackEntity>> stream() {
    return _objectboxProvider.stream<TrackModel>();
  }

  @override
  void toggleFavorite(TrackEntity track) async {
    final entity = await _objectboxProvider.get<TrackModel>(track.id);

    if (entity == null) return;

    entity.isFavorite = !entity.isFavorite;
    _objectboxProvider.update(entity);
  }
}
