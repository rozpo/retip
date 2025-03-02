import 'package:flutter/material.dart';

abstract class ThemeRepository {
  Future<bool> setThemeMode(ThemeMode mode);

  ThemeMode getThemeMode();

  Future<bool> setThemeColor(Color color);

  Color getThemeColor();

  Future<bool> setBatterySaver(bool saveBattery);

  bool getBatterySaver();

  Future<bool> setGridViewColumns(int columns);

  int getGridViewColumns();
}
