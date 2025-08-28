import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/errors/result.dart';
import '../../../domain/repositories/permissions_repository.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  final PermissionsRepository _permissionsRepository;

  PermissionsBloc({required PermissionsRepository permissionsRepository})
    : _permissionsRepository = permissionsRepository,
      super(PermissionsInitState()) {
    on<PermissionsCheckEvent>(_checkPermissions);
    on<PermissionsRequestEvent>(_requestPermissions);

    add(PermissionsCheckEvent());
  }

  void _checkPermissions(
    PermissionsCheckEvent event,
    Emitter<PermissionsState> emit,
  ) async {
    final result = await _permissionsRepository.checkPermissions();

    if (result is ResultSuccess<bool> && result.data) {
      emit(PermissionsGrantedState());
    } else {
      emit(PermissionsNeededState());
    }
  }

  void _requestPermissions(
    PermissionsRequestEvent event,
    Emitter<PermissionsState> emit,
  ) async {
    final result = await _permissionsRepository.requestPermissions();

    if (result is ResultSuccess<bool> && result.data) {
      emit(PermissionsGrantedState());
    } else {
      emit(PermissionsNeededState());
    }
  }
}
