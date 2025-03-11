import '../../../objectbox.g.dart';
import '../../domain/entities/playlist_entity.dart';
import '../../domain/entities/track_entity.dart';
import '../../domain/repositories/playlist_repository.dart';
import '../models/playlist_model.dart';
import '../models/track_model.dart';
import '../providers/objectbox_provider.dart';

class PlaylistRepositoryI implements PlaylistRepository {
  final ObjectboxProvider _objectboxProvider;

  PlaylistRepositoryI({required ObjectboxProvider objectboxProvider})
      : _objectboxProvider = objectboxProvider;

  @override
  Stream<PlaylistEntity?> read(int id) {
    return _objectboxProvider.streamOne(PlaylistModel_.id.equals(id));
  }

  @override
  Stream<List<PlaylistEntity>> stream() {
    return _objectboxProvider.stream<PlaylistModel>();
  }

  @override
  void toggleFavorite(PlaylistEntity playlist) async {
    final entity = await _objectboxProvider.get<PlaylistModel>(playlist.id);

    if (entity == null) return;

    entity.isFavorite = !entity.isFavorite;
    _objectboxProvider.update(entity);
  }

  @override
  void create(String name, [List<TrackEntity> tracks = const []]) async {
    final entity = PlaylistModel(name: name);

    if (tracks.isNotEmpty) {
      entity.tracksDb.addAll(tracks as List<TrackModel>);
    }

    _objectboxProvider.insert(entity);
  }

  @override
  void delete(int id) {
    _objectboxProvider.remove(id);
  }

  @override
  void update(PlaylistEntity playlist) async {
    _objectboxProvider.update(playlist as PlaylistModel);
  }
}
