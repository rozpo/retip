import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'permissions_state.dart';

class PermissionsCubit extends HydratedCubit<PermissionsState> {
  PermissionsCubit() : super(PermissionsState());

  void granted() => emit(PermissionsState(true));

  void reset() => emit(PermissionsState(false));

  @override
  PermissionsState? fromJson(Map<String, dynamic> json) {
    return PermissionsState(json['isGranted']);
  }

  @override
  Map<String, dynamic>? toJson(PermissionsState state) {
    return {'isGranted': state.isGranted};
  }
}
