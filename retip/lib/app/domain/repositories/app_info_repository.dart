import 'package:retip/app/domain/enitities/app_info_entity.dart';
import 'package:retip/app/domain/errors/result.dart';

abstract interface class AppInfoRepository {
  Result<AppInfoEntity> info();
}
