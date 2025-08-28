import 'package:retip/app/domain/errors/result.dart';

abstract interface class PermissionsRepository {
  /// Requests the necessary permissions and returns `true` if granted, `false` otherwise.
  Future<Result<bool>> requestPermissions();

  /// Checks if the necessary permissions are granted.
  Future<Result<bool>> checkPermissions();
}
