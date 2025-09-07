import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:retip/core/theme/retip_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState());

  void setThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  void setSeedColor(Color seedColor) {
    emit(state.copyWith(seedColor: seedColor));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final argb = json['seedColor'] as int?;
    final color = argb != null ? Color(argb) : null;

    final modeName = json['themeMode'] as String?;
    final themeMode = modeName != null
        ? ThemeMode.values.firstWhere((e) => e.name == modeName)
        : ThemeMode.system;

    return ThemeState(
      seedColor: color ?? RetipTheme.primaryColor,
      themeMode: themeMode,
    );
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {
      'seedColor': state.seedColor.toARGB32(),
      'themeMode': state.themeMode.name,
    };
  }
}
