part of 'settings_cubit.dart';

@immutable
final class SettingsState {
  final ThemeMode themeMode;

  const SettingsState({this.themeMode = ThemeMode.system});

  SettingsState copyWith({ThemeMode? themeMode}) {
    return SettingsState(themeMode: themeMode ?? this.themeMode);
  }
}
