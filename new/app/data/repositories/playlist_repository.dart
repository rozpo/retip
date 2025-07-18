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
    return await _objectboxProvider.insert<PlaylistModel>(playlist);
  }

  Future<bool> rename(int id, String name) async {
    final playlist = await _objectboxProvider.get<PlaylistModel>(id);
    if (playlist == null) return false;

    playlist.name = name;
    return await _objectboxProvider.update(playlist) > 0;
  }

  Future<bool> delete(int id) async {
    return await _objectboxProvider.delete<PlaylistModel>(id);
  }

  Stream<List<PlaylistEntity>> watchAll() {
    return _objectboxProvider.watchAll<PlaylistModel>();
  }
}
