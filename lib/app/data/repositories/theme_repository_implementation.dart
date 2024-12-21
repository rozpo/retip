import 'package:flutter/material.dart';
import 'package:retip/app/data/providers/shared_preferences_provider.dart';
import 'package:retip/app/services/repositories/theme_repository.dart';
import 'package:retip/core/theme/retip_theme.dart';

enum Keys {
  themeGridViewColumns,
  themeBatterySaver,
  themeColor,
  themeMode,
}

class ThemeRepositoryImplementation extends ThemeRepository {
  final SharedPreferencesProvider provider;

  ThemeRepositoryImplementation({required this.provider});

  @override
  ThemeMode getThemeMode() {
    final userMode = provider.getBool(Keys.themeMode.name, true);
    return userMode ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Future<bool> setThemeMode(ThemeMode mode) async {
    final value = mode == ThemeMode.dark;
    return await provider.setBool(Keys.themeMode.name, value);
  }

  @override
  Color getThemeColor() {
    final color = provider.getString(Keys.themeColor.name) ??
        RetipTheme.primaryColor.toString();

    return Colors.primaries.firstWhere((element) {
      return element.toString() == color;
    });
  }

  @override
  Future<bool> setThemeColor(Color color) {
    return provider.setString(Keys.themeColor.name, color.toString());
  }

  @override
  bool getBatterySaver() {
    return provider.getBool(Keys.themeBatterySaver.name);
  }

  @override
  Future<bool> setBatterySaver(bool saveBattery) async {
    return await provider.setBool(Keys.themeBatterySaver.name, saveBattery);
  }

  @override
  int getGridViewColumns() {
    return provider.getInt(Keys.themeGridViewColumns.name, 2);
  }

  @override
  Future<bool> setGridViewColumns(int columns) async {
    return await provider.setInt(Keys.themeGridViewColumns.name, columns);
  }
}
