part of 'permissions_bloc.dart';

@immutable
sealed class PermissionsEvent {}

class PermissionsCheckEvent extends PermissionsEvent {}

class PermissionsRequestEvent extends PermissionsEvent {}
