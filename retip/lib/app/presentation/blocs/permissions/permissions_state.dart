part of 'permissions_bloc.dart';

@immutable
sealed class PermissionsState {
  const PermissionsState();

  @override
  String toString() {
    return runtimeType.toString();
  }
}

final class PermissionsInitState extends PermissionsState {
  const PermissionsInitState();
}

final class PermissionsNeededState extends PermissionsState {
  const PermissionsNeededState();
}

final class PermissionsGrantedState extends PermissionsState {
  const PermissionsGrantedState();
}
