import 'package:retip/app/domain/errors/result.dart';

abstract interface class PermissionsRepository {
  Future<Result<bool>> permissionsCheck();

  Future<Result<bool>> permissionsRequest();
}
