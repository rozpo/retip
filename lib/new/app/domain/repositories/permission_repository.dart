abstract class PermissionRepository {
  /// Check if the permission is granted
  Future<bool> check();

  /// Request the permission using the platform's permission handler
  Future<bool> request();
}
