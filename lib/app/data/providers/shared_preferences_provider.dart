import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesProvider({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  static const albumPrefix = 'art_album_';
  static const artistPrefix = 'art_artist_';

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  bool getBool(String key, [bool fallback = false]) {
    return _sharedPreferences.getBool(key) ?? fallback;
  }

  Future<bool> setInt(String key, int value) async {
    return await _sharedPreferences.setInt(key, value);
  }

  int getInt(String key, [int fallback = 0]) {
    return _sharedPreferences.getInt(key) ?? fallback;
  }

  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _sharedPreferences.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }
}
