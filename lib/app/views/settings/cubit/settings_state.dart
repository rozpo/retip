part of 'settings_cubit.dart';

@immutable
class SettingsState {
  final bool darkMode;

  const SettingsState({
    this.darkMode = false,
  });

  SettingsState copyWith({bool? darkMode}) {
    return SettingsState(
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
