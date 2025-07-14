part of 'permissions_bloc.dart';

@immutable
sealed class PermissionsState {
  const PermissionsState();
}

final class PermissionsRequiredState extends PermissionsState {
  const PermissionsRequiredState();
}

final class PermissionsGrantedState extends PermissionsState {
  const PermissionsGrantedState();
}
