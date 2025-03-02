abstract class PermissionRepository {
  Future<bool> storagePermissionRequest();

  Future<bool> storagePermissionStatus();
}
