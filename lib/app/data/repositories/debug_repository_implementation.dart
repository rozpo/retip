import 'package:flutter/foundation.dart';

import '../../domain/repositories/debug_repository.dart';
import '../providers/shared_preferences_provider.dart';

enum Keys {
  debugShowCheckedModeBanner(kDebugMode),
  debugRepaintRainbowEnabled(kDebugMode),
  debugInvertOversizedImages(kDebugMode),
  showPerformanceOverlay(kProfileMode);

  final bool fallback;

  const Keys(this.fallback);
}

class DebugRepositoryImplementation implements DebugRepository {
  final SharedPreferencesProvider _sharedPreferencesProvider;

  DebugRepositoryImplementation({
    required SharedPreferencesProvider sharedPreferencesProvider,
  }) : _sharedPreferencesProvider = sharedPreferencesProvider;

  bool _getBool(Keys key) {
    return _sharedPreferencesProvider.getBool(key.name, key.fallback);
  }

  void _setBool(Keys key, bool value) {
    _sharedPreferencesProvider.setBool(key.name, value);
  }

  @override
  bool getDebugInvertOversizedImages() {
    return _getBool(Keys.debugInvertOversizedImages);
  }

  @override
  bool getDebugRepaintRainbowEnabled() {
    return _getBool(Keys.debugRepaintRainbowEnabled);
  }

  @override
  bool getDebugShowCheckedModeBanner() {
    return _getBool(Keys.debugShowCheckedModeBanner);
  }

  @override
  bool getShowPerformanceOverlay() {
    return _getBool(Keys.showPerformanceOverlay);
  }

  @override
  void setDebugInvertOversizedImages(bool value) {
    _setBool(Keys.debugInvertOversizedImages, value);
  }

  @override
  void setDebugRepaintRainbowEnabled(bool value) {
    _setBool(Keys.debugRepaintRainbowEnabled, value);
  }

  @override
  void setDebugShowCheckedModeBanner(bool value) {
    _setBool(Keys.debugShowCheckedModeBanner, value);
  }

  @override
  void setShowPerformanceOverlay(bool value) {
    _setBool(Keys.showPerformanceOverlay, value);
  }
}
