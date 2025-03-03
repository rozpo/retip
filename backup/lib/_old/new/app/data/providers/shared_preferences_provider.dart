import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesProvider({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  bool getBool(String key) {
    return _sharedPreferences.getBool(key) ?? false;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }
}
