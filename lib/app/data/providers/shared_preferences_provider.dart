import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  static Future<SharedPreferencesProvider> init() async {
    final sharedPreferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );

    return SharedPreferencesProvider._(sharedPreferences);
  }

  final SharedPreferencesWithCache _sharedPreferences;

  SharedPreferencesProvider._(
    SharedPreferencesWithCache sharedPreferences,
  ) : _sharedPreferences = sharedPreferences;

  bool getBool(String key, [bool fallback = false]) {
    return _sharedPreferences.getBool(key) ?? fallback;
  }

  int getInt(String key, [int fallback = 0]) {
    return _sharedPreferences.getInt(key) ?? fallback;
  }

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  Future<void> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  Future<void> setInt(String key, int value) async {
    return await _sharedPreferences.setInt(key, value);
  }

  Future<void> setString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  Future<void> setStringList(String key, List<String> value) async {
    return await _sharedPreferences.setStringList(key, value);
  }
}
