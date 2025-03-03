part of 'permission_bloc.dart';

@immutable
sealed class PermissionState {
  const PermissionState();
}

final class PermissionInitial extends PermissionState {
  const PermissionInitial();
}

final class PermissionGranted extends PermissionState {
  const PermissionGranted();
}
