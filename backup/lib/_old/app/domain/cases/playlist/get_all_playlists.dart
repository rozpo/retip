import 'package:get_it/get_it.dart';
import 'read_playlist.dart';
import '../../entities/playlist_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin GetAllPlaylists {
  static Future<List<PlaylistEntity>> call() async {
    final prefs = GetIt.I.get<SharedPreferences>();
    final keys = prefs.getKeys().where((key) => key.startsWith('pl_'));

    List<PlaylistEntity> playlists = [];

    for (final key in keys) {
      final playlist = await ReadPlaylist.call(key);
      if (playlist != null) {
        playlists.add(playlist);
      }
    }

    return playlists;
  }
}
