import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin UpdatePlaylist {
  static Future<bool> call(String name, List<TrackEntity> tracks) async {
    final prefs = GetIt.I.get<SharedPreferences>();

    final key = 'pl_$name';
    final trackIds = prefs.getStringList(key);
    if (trackIds == null) {
      return false;
    }

    return await prefs.setStringList(
        key, tracks.map((track) => track.id.toString()).toList());
  }
}
