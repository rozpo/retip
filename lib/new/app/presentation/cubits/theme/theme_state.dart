part of 'theme_cubit.dart';

@immutable
class ThemeState {
  final Color primaryColor;

  const ThemeState({
    this.primaryColor = Colors.lightBlue,
  });

  ThemeState copyWith({
    Color? primaryColor,
  }) {
    return ThemeState(
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}
