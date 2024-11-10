import 'package:get_it/get_it.dart';
import 'package:retip/app/services/cases/get_all_tracks.dart';
import 'package:retip/app/services/entities/playlist_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin ReadPlaylist {
  static Future<PlaylistEntity?> call(String key) async {
    final prefs = GetIt.I.get<SharedPreferences>();

    final trackIds = prefs.getStringList(key);
    if (trackIds == null) {
      return null;
    }
    final allTracks = await GetAllTracks.call();

    final tracks = allTracks
        .where((track) => trackIds.contains(track.id.toString()))
        .toList();

    return PlaylistEntity(
      id: 0,
      uuid: key.split('_')[1],
      name: trackIds.first,
      tracks: tracks,
    );
  }
}
