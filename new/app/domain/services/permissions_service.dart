import '../../data/repositories/config_repository.dart';
import '../../data/repositories/permissions_repository.dart';
import '../enums/config_enum.dart';

interface class PermissionsService {
  final PermissionsRepository _permissionsRepository;
  final ConfigRepository _configRepository;

  const PermissionsService({
    required PermissionsRepository permissionRepository,
    required ConfigRepository configRepository,
  })  : _permissionsRepository = permissionRepository,
        _configRepository = configRepository;

  bool getMediaPermissions() {
    return _configRepository.getValue(ConfigEnum.permissions);
  }

  Future<void> setMediaPermission(bool value) async {
    return await _configRepository.setValue(ConfigEnum.permissions, value);
  }

  Future<bool> checkMediaPermissions() async {
    return await _permissionsRepository.getMediaPermission();
  }

  Future<bool> requestMediaPermissions() async {
    return await _permissionsRepository.requestMediaPermission();
  }
}
