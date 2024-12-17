part of 'settings_cubit.dart';

@immutable
class SettingsState {
  final Color themeColor;
  final bool darkMode;
  final bool batterySaver;

  const SettingsState({
    this.themeColor = RetipTheme.primaryColor,
    this.batterySaver = false,
    this.darkMode = true,
  });

  SettingsState copyWith({
    Color? themeColor,
    bool? batterySaver,
    bool? darkMode,
  }) {
    return SettingsState(
      themeColor: themeColor ?? this.themeColor,
      batterySaver: batterySaver ?? this.batterySaver,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
