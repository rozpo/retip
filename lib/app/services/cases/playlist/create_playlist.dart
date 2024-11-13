import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

mixin CreatePlaylist {
  static Future<bool> call(String name, [TrackEntity? track]) async {
    final prefs = GetIt.I.get<SharedPreferences>();

    final key = 'pl_${const Uuid().v4()}';

    if (prefs.containsKey(key)) {
      return false;
    }

    return await prefs.setStringList(key, [
      name,
      if (track != null) track.id.toString(),
    ]);
  }
}
