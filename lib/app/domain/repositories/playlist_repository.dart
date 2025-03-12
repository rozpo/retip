import '../entities/playlist_entity.dart';
import '../entities/track_entity.dart';

abstract class PlaylistRepository {
  Stream<List<PlaylistEntity>> stream();

  void toggleFavorite(PlaylistEntity playlist);

  void create(String name, [List<TrackEntity> tracks = const []]);

  Stream<PlaylistEntity?> read(int id);

  void update(PlaylistEntity playlist);

  void delete(int id);

  void addTrack(int playlistId, int trackId);

  void removeTrack(int playlistId, int trackId);

  Future<List<PlaylistEntity>> getAll();
}
