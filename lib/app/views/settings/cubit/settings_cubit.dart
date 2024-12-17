import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:retip/app/data/providers/shared_preferences_provider.dart';
import 'package:retip/app/data/repositories/theme_repository_implementation.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final repository = ThemeRepositoryImplementation(
    provider: SharedPreferencesProvider(),
  );

  SettingsCubit() : super(const SettingsState()) {
    final isDarkMode = repository.getThemeMode() == ThemeMode.dark;

    emit(state.copyWith(darkMode: isDarkMode));
  }

  void toggleDarkMode() async {
    final themeMode = state.darkMode ? ThemeMode.light : ThemeMode.dark;
    final result = await repository.setThemeMode(themeMode);

    if (result) {
      emit(state.copyWith(darkMode: !state.darkMode));
    }
  }
}
