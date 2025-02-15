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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is ThemeState) {
      return other.primaryColor == primaryColor;
    }

    return false;
  }

  @override
  int get hashCode => super.hashCode ^ primaryColor.hashCode;
}
