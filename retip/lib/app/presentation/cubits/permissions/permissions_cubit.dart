import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/permissions_repository.dart';

part 'permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  final PermissionsRepository _permissionsRepository;

  PermissionsCubit({
    required PermissionsRepository permissionsRepository,
    bool isGranted = false,
  }) : _permissionsRepository = permissionsRepository,
       super(PermissionsState(isGranted));

  Future<void> ask() async {
    if (state.isGranted) return;

    final result = await _permissionsRepository.permissionsRequest();

    if (result is ResultSuccess<bool>) {
      emit(PermissionsState(true));
    } else {
      emit(PermissionsState(false));
    }
  }
}
