import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/domain/enitities/app_info_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/app_info_repository.dart';

part 'app_info_state.dart';

class AppInfoCubit extends Cubit<AppInfoState> {
  factory AppInfoCubit(AppInfoRepository appInfoRepository) {
    final result = appInfoRepository.info();

    if (result is ResultSuccess<AppInfoEntity>) {
      return AppInfoCubit._(result.data);
    } else {
      throw Exception('AppInfoCubit exception');
    }
  }

  AppInfoCubit._(AppInfoEntity data) : super(AppInfoState(data));
}
