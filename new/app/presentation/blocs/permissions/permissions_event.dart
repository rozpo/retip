part of 'permissions_bloc.dart';

@immutable
sealed class PermissionsEvent {
  const PermissionsEvent();
}

final class PermissionsRequestEvent extends PermissionsEvent {
  const PermissionsRequestEvent();
}

final class PermissionsGrantEvent extends PermissionsEvent {
  const PermissionsGrantEvent();
}

final class PermissionsRevokeEvent extends PermissionsEvent {
  const PermissionsRevokeEvent();
}
