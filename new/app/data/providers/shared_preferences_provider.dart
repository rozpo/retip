import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  final SharedPreferencesWithCache _sharedPreferences;

  const SharedPreferencesProvider._(
    SharedPreferencesWithCache sharedPreferences,
  ) : _sharedPreferences = sharedPreferences;

  static Future<SharedPreferencesProvider> init() async {
    final sharedPreferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );

    return SharedPreferencesProvider._(sharedPreferences);
  }

  bool getBool(String key, [bool fallback = false]) {
    return _sharedPreferences.getBool(key) ?? fallback;
  }

  Future<void> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }
}
