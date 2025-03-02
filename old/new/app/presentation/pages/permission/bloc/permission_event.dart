part of 'permission_bloc.dart';

@immutable
sealed class PermissionEvent {
  const PermissionEvent();
}

class AskForPermissionEvent extends PermissionEvent {
  const AskForPermissionEvent();
}

class OpenAppSettingsEvent extends PermissionEvent {
  const OpenAppSettingsEvent();
}
