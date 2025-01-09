part of 'intro_bloc.dart';

@immutable
sealed class IntroEvent {}

class IntroAskPermissionsEvent extends IntroEvent {}

class IntroCheckPermissionsEvent extends IntroEvent {}

class IntroLibraryScanEvent extends IntroEvent {}
