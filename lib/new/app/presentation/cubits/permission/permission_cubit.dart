import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(const PermissionState());

  void requestPermission() async {
    emit(state.copyWith(isGranted: true));
  }
}
