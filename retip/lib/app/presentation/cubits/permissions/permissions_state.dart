part of 'permissions_cubit.dart';

@immutable
final class PermissionsState {
  final bool isGranted;

  const PermissionsState([this.isGranted = false]);
}
