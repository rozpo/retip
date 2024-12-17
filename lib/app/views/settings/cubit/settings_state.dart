part of 'settings_cubit.dart';

@immutable
class SettingsState {
  final Color themeColor;
  final bool darkMode;

  const SettingsState({
    this.themeColor = RetipTheme.primaryColor,
    this.darkMode = true,
  });

  SettingsState copyWith({
    Color? themeColor,
    bool? darkMode,
  }) {
    return SettingsState(
      themeColor: themeColor ?? this.themeColor,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
