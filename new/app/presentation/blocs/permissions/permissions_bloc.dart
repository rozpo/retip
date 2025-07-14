import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/services/permissions_service.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  final PermissionsService _permissionsService;

  PermissionsBloc({
    required PermissionsService permissionsService,
  })  : _permissionsService = permissionsService,
        super(permissionsService.getMediaPermissions()
            ? const PermissionsGrantedState()
            : const PermissionsRequiredState()) {
    on<PermissionsRequestEvent>(_onRequest);
    on<PermissionsGrantEvent>(_onGrant);
    on<PermissionsRevokeEvent>(_onRevoke);

    _permissionsService.checkMediaPermissions().then((value) {
      if (value == false && state is PermissionsGrantedState) {
        add(const PermissionsRevokeEvent());
      } else if (value && state is PermissionsRequiredState) {
        add(const PermissionsGrantEvent());
      }
    });
  }

  void _onRequest(
      PermissionsRequestEvent event, Emitter<PermissionsState> emit) async {
    final result = await _permissionsService.requestMediaPermissions();

    result
        ? emit(const PermissionsGrantedState())
        : emit(const PermissionsRequiredState());
  }

  void _onGrant(PermissionsGrantEvent event, Emitter<PermissionsState> emit) {
    _permissionsService.setMediaPermission(true);
    emit(const PermissionsGrantedState());
  }

  void _onRevoke(PermissionsRevokeEvent event, Emitter<PermissionsState> emit) {
    _permissionsService.setMediaPermission(false);
    emit(const PermissionsRequiredState());
  }
}
