import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState());

  void changeThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }
}
