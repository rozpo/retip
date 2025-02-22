import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/permission_usecase.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  final PermissionUsecase _permissionUsecase;
  PermissionBloc({
    required PermissionUsecase permissionUsecase,
  })  : _permissionUsecase = permissionUsecase,
        super(const PermissionInitial()) {
    on<AskForPermissionEvent>(_onAskForPermission);
    on<OpenAppSettingsEvent>(_onOpenAppSettings);
  }

  void _onAskForPermission(
    AskForPermissionEvent event,
    Emitter<PermissionState> emit,
  ) async {
    final result = await _permissionUsecase.askForMediaPermission();

    if (result) {
      emit(const PermissionGranted());
    }
  }

  void _onOpenAppSettings(
    OpenAppSettingsEvent event,
    Emitter<PermissionState> emit,
  ) {
    _permissionUsecase.openAppSettings();
  }
}
