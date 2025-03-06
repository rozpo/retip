part of 'permission_cubit.dart';

@immutable
sealed class PermissionState {}

final class PermissionInitial extends PermissionState {}

final class PermissionMissing extends PermissionState {}

final class PermissionGranted extends PermissionState {}
