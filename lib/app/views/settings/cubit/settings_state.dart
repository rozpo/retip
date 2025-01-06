part of 'settings_cubit.dart';

@immutable
class SettingsState {
  final int gridViewColumns;
  final bool batterySaver;
  final bool keepPlayback;
  final Color themeColor;
  final bool autoplay;
  final bool darkMode;

  const SettingsState({
    this.gridViewColumns = LayoutConstants.minGridViewColumns,
    this.themeColor = RetipTheme.primaryColor,
    this.batterySaver = false,
    this.keepPlayback = true,
    this.autoplay = false,
    this.darkMode = true,
  });

  SettingsState copyWith({
    int? gridViewColumns,
    bool? batterySaver,
    bool? keepPlayback,
    Color? themeColor,
    bool? autoplay,
    bool? darkMode,
  }) {
    return SettingsState(
      gridViewColumns: gridViewColumns ?? this.gridViewColumns,
      batterySaver: batterySaver ?? this.batterySaver,
      keepPlayback: keepPlayback ?? this.keepPlayback,
      themeColor: themeColor ?? this.themeColor,
      autoplay: autoplay ?? this.autoplay,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
