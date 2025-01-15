import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  static const albumPrefix = 'art_album_';
  static const artistPrefix = 'art_artist_';

  final _prefs = GetIt.I.get<SharedPreferences>();

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool getBool(String key, [bool fallback = false]) {
    return _prefs.getBool(key) ?? fallback;
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int getInt(String key, [int fallback = 0]) {
    return _prefs.getInt(key) ?? fallback;
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }
}
