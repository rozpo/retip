abstract class PermissionRepository {
  Future<bool> getMediaPermissionStatus();

  Future<bool> requestMediaPermission();
}
