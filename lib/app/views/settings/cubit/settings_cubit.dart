import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:retip/app/services/repositories/theme_repository.dart';
import 'package:retip/core/theme/retip_theme.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ThemeRepository repository;

  SettingsCubit(this.repository) : super(const SettingsState()) {
    final isDarkMode = repository.getThemeMode() == ThemeMode.dark;
    final themeColor = repository.getThemeColor();
    final batterySaver = repository.getBatterySaver();

    emit(state.copyWith(
      themeColor: themeColor,
      darkMode: isDarkMode,
      batterySaver: batterySaver,
    ));
  }

  void toggleDarkMode() async {
    final themeMode = state.darkMode ? ThemeMode.light : ThemeMode.dark;
    final result = await repository.setThemeMode(themeMode);

    if (result) {
      emit(state.copyWith(darkMode: !state.darkMode));
    }
  }

  void toggleBatterySaver() async {
    final result = await repository.setBatterySaver(!state.batterySaver);

    if (result) {
      emit(state.copyWith(batterySaver: !state.batterySaver));
    }
  }

  void setColorTheme(Color color) async {
    final result = await repository.setThemeColor(color);

    if (result) {
      emit(state.copyWith(themeColor: color));
    }
  }
}
