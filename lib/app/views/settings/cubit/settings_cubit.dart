import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:retip/app/services/repositories/audio_repository.dart';
import 'package:retip/app/services/repositories/theme_repository.dart';
import 'package:retip/core/constants/layout_constants.dart';
import 'package:retip/core/theme/retip_theme.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final AudioRepository audioRepository;
  final ThemeRepository themeRepository;

  SettingsCubit({
    required this.audioRepository,
    required this.themeRepository,
  }) : super(const SettingsState()) {
    final isDarkMode = themeRepository.getThemeMode() == ThemeMode.dark;
    final gridViewColumns = themeRepository.getGridViewColumns();
    final batterySaver = themeRepository.getBatterySaver();
    final themeColor = themeRepository.getThemeColor();

    final autoplay = audioRepository.getAutoplay();
    final keepPlayback = audioRepository.getKeepPlayback();

    emit(state.copyWith(
      gridViewColumns: gridViewColumns,
      batterySaver: batterySaver,
      keepPlayback: keepPlayback,
      themeColor: themeColor,
      darkMode: isDarkMode,
      autoplay: autoplay,
    ));
  }

  void toggleDarkMode() async {
    final themeMode = state.darkMode ? ThemeMode.light : ThemeMode.dark;
    final result = await themeRepository.setThemeMode(themeMode);

    if (result) {
      emit(state.copyWith(darkMode: !state.darkMode));
    }
  }

  void toggleBatterySaver() async {
    final result = await themeRepository.setBatterySaver(!state.batterySaver);

    if (result) {
      emit(state.copyWith(batterySaver: !state.batterySaver));
    }
  }

  void setColorTheme(Color color) async {
    final result = await themeRepository.setThemeColor(color);

    if (result) {
      emit(state.copyWith(themeColor: color));
    }
  }

  void setGridViewColumns(int columns) async {
    final result = await themeRepository.setGridViewColumns(columns);

    if (result) {
      emit(state.copyWith(gridViewColumns: columns));
    }
  }

  void toggleKeepPlayback() async {
    final result = await audioRepository.setKeepPlayback(!state.keepPlayback);

    if (result) {
      emit(state.copyWith(keepPlayback: !state.keepPlayback));
    }
  }

  void toggleAutoplay() async {
    final result = await audioRepository.setAutoplay(!state.autoplay);

    if (result) {
      emit(state.copyWith(autoplay: !state.autoplay));
    }
  }
}
