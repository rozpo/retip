import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repositories/permission_repository.dart';
import '../../../domain/repositories/settings_repository.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  final PermissionRepository _permissionRepository;
  final SettingsRepository _settingsRepository;

  PermissionCubit({
    required PermissionRepository permissionRepository,
    required SettingsRepository settingsRepository,
  })  : _permissionRepository = permissionRepository,
        _settingsRepository = settingsRepository,
        super(PermissionInitial()) {
    _permissionRepository.getMediaPermissionStatus().then((status) {
      if (status) {
        emit(PermissionGranted());
      } else {
        emit(PermissionMissing());
      }
    });
  }

  void requestMediaPermission() async {
    final result = await _permissionRepository.requestMediaPermission();

    if (result == false) return;
    emit(PermissionGranted());
  }

  void openAppSettings() async {
    await _settingsRepository.openAppSettings();
  }
}
