import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:retip/app/data/providers/shared_preferences_provider.dart';
import 'package:retip/app/domain/repositories/theme_repository.dart';
import 'package:retip/core/extensions/color_extension.dart';
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
    final data = provider.getString(Keys.themeColor.name);

    if (data == null) {
      return RetipTheme.primaryColor;
    }

    try {
      return ColorExtension.fromJson(jsonDecode(data));
    } catch (e) {
      setThemeColor(RetipTheme.primaryColor);
      return RetipTheme.primaryColor;
    }
  }

  @override
  Future<bool> setThemeColor(Color color) async {
    try {
      final data = jsonEncode(color.toJson());
      return await provider.setString(Keys.themeColor.name, data);
    } catch (e) {
      return false;
    }
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
