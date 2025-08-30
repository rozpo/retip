part of 'permissions_bloc.dart';

@immutable
sealed class PermissionsEvent {
  const PermissionsEvent();

  @override
  String toString() {
    return runtimeType.toString();
  }
}

class PermissionsCheckEvent extends PermissionsEvent {
  const PermissionsCheckEvent();
}

class PermissionsRequestEvent extends PermissionsEvent {
  const PermissionsRequestEvent();
}
