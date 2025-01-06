import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/data/providers/retip_permission.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(IntroIdle()) {
    on<IntroCheckPermissionsEvent>(_checkPermissions);
    on<IntroAskPermissionsEvent>(_askPermissions);
  }

  void _checkPermissions(
    IntroCheckPermissionsEvent event,
    Emitter<IntroState> emit,
  ) async {
    emit(IntroCheckingPermissions());

    if (await RetipPermission.check()) {
      emit(IntroPermissionsGranted());
    } else {
      emit(IntroIdle());
    }
  }

  void _askPermissions(
    IntroAskPermissionsEvent event,
    Emitter<IntroState> emit,
  ) async {
    emit(IntroCheckingPermissions());

    if (await RetipPermission.checkAndRequest()) {
      emit(IntroPermissionsGranted());
    } else {
      emit(IntroIdle());
    }
  }
}
