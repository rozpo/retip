import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin DeletePlaylist {
  static Future<bool> call(int id) async {
    final prefs = GetIt.I.get<SharedPreferences>();

    final key = 'pl_$id';
    await prefs.reload();
    final result = await prefs.remove(key);

    return result;
  }
}
