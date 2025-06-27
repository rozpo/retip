part of 'theme_cubit.dart';

@immutable
final class ThemeState {
  final ThemeMode themeMode;

  const ThemeState({this.themeMode = ThemeMode.system});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }
}
