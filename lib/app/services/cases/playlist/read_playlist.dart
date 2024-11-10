import 'package:get_it/get_it.dart';
import 'package:retip/app/services/cases/get_all_tracks.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin ReadPlaylist {
  static Future<List<TrackEntity>> call(String name) async {
    final prefs = GetIt.I.get<SharedPreferences>();

    final key = 'pl_$name';
    final trackIds = prefs.getStringList(key);
    if (trackIds == null) {
      return [];
    }
    final allTracks = await GetAllTracks.call();

    return allTracks
        .where((track) => trackIds.contains(track.id.toString()))
        .toList();
  }
}
