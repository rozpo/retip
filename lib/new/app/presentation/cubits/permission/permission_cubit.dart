import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repositories/permission_repository.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  final PermissionRepository _permissionRepository;

  PermissionCubit({
    required PermissionRepository permissionRepository,
  })  : _permissionRepository = permissionRepository,
        super(const PermissionState()) {
    _permissionRepository.check().then((isGranted) {
      emit(state.copyWith(isGranted: isGranted));
    });
  }

  void requestPermission() async {
    final isGranted = await _permissionRepository.request();
    emit(state.copyWith(isGranted: isGranted));
  }
}
