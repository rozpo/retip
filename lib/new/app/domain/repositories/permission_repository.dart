abstract class PermissionRepository {
  Future<bool> askForMediaPermission();
  Future<bool> hasMediaPermission();
  Future<void> openAppSettings();
}
