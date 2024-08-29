part of 'intro_bloc.dart';

@immutable
sealed class IntroState {}

final class IntroIdle extends IntroState {}

final class IntroCheckingPermissions extends IntroState {}

final class IntroPermissionsGranted extends IntroState {}
