part of 'theme_cubit.dart';

@immutable
final class ThemeState {
  final ThemeMode themeMode;
  final Color seedColor;

  const ThemeState({
    this.seedColor = RetipTheme.primaryColor,
    this.themeMode = ThemeMode.system,
  });

  ThemeState copyWith({ThemeMode? themeMode, Color? seedColor}) {
    return ThemeState(
      seedColor: seedColor ?? this.seedColor,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  String toString() {
    return 'seedColor= $seedColor\n'
        'themeMode = $themeMode';
  }
}
