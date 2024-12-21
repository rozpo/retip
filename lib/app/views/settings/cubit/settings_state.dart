part of 'settings_cubit.dart';

@immutable
class SettingsState {
  final int gridViewColumns;
  final bool batterySaver;
  final Color themeColor;
  final bool darkMode;

  const SettingsState({
    this.themeColor = RetipTheme.primaryColor,
    this.batterySaver = false,
    this.gridViewColumns = RetipConfig.minGridViewColumns,
    this.darkMode = true,
  });

  SettingsState copyWith({
    int? gridViewColumns,
    bool? batterySaver,
    Color? themeColor,
    bool? darkMode,
  }) {
    return SettingsState(
      gridViewColumns: gridViewColumns ?? this.gridViewColumns,
      batterySaver: batterySaver ?? this.batterySaver,
      themeColor: themeColor ?? this.themeColor,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
