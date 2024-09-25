import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RetipConfigBoolKey {
  debugShowCheckedModeBanner(kDebugMode),
  debugRepaintRainbowEnabled(kDebugMode),
  debugInvertOversizedImages(kDebugMode),
  showPerformanceOverlay(kProfileMode);

  final bool defaultValue;

  const RetipConfigBoolKey(this.defaultValue);
}

mixin RetipConfig {
  static bool getBool(RetipConfigBoolKey key) {
    final prefs = GetIt.instance.get<SharedPreferences>();
    return prefs.getBool(key.name) ?? key.defaultValue;
  }

  static Future<bool> setBool(RetipConfigBoolKey key, bool value) async {
    final prefs = GetIt.instance.get<SharedPreferences>();
    return await prefs.setBool(key.name, value);
  }
}
