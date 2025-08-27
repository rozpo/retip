import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesProvider._(SharedPreferences sharedPreferences)
    : _sharedPreferences = sharedPreferences;

  static Future<SharedPreferencesProvider> init() async {
    final prefs = await SharedPreferences.getInstance();

    return SharedPreferencesProvider._(prefs);
  }

  bool getBool(String key, [bool fallback = false]) {
    return _sharedPreferences.getBool(key) ?? fallback;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }
}
