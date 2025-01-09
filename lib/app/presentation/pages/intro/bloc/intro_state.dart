part of 'intro_bloc.dart';

@immutable
sealed class IntroState {
  const IntroState();
}

final class IntroIdle extends IntroState {}

final class IntroCheckingPermissions extends IntroState {}

final class IntroPermissionsGranted extends IntroState {}

final class IntroLibraryScanning extends IntroState {
  final String? filename;
  final double progress;

  const IntroLibraryScanning({
    required this.progress,
    this.filename,
  });
}

final class IntroLibraryScanned extends IntroState {}
