import '../../domain/entites/playlist_entity.dart';
import '../models/playlist_model.dart';
import '../providers/objectbox_provider.dart';

interface class PlaylistRepository {
  final ObjectboxProvider _objectboxProvider;

  const PlaylistRepository({
    required ObjectboxProvider objectboxProvider,
  }) : _objectboxProvider = objectboxProvider;

  Future<int> create(String name) async {
    final playlist = PlaylistModel(name: name);
    return await _objectboxProvider.insert(playlist);
  }

  Stream<List<PlaylistEntity>> watchAll() {
    return _objectboxProvider.watchAll<PlaylistModel>();
  }
}
