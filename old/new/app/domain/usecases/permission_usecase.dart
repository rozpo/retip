import '../repositories/permission_repository.dart';

class PermissionUsecase {
  final PermissionRepository _permissionRepository;

  const PermissionUsecase({
    required PermissionRepository permissionRepository,
  }) : _permissionRepository = permissionRepository;

  Future<bool> askForMediaPermission() async {
    return await _permissionRepository.askForMediaPermission();
  }

  Future<bool> hasMediaPermission() async {
    return await _permissionRepository.hasMediaPermission();
  }

  Future<void> openAppSettings() async {
    await _permissionRepository.openAppSettings();
  }
}
