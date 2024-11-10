import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin CreatePlaylist {
  static Future<bool> call(String name) async {
    final prefs = GetIt.I.get<SharedPreferences>();

    final key = 'pl_$name';

    if (prefs.containsKey(key)) {
      return false;
    }

    return await prefs.setStringList(key, []);
  }
}
