import 'package:retip/app/data/models/app_info_model.dart';
import 'package:retip/app/data/providers/package_info_provider.dart';
import 'package:retip/app/domain/enitities/app_info_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/app_info_repository.dart';

final class AppInfoRepositoryI implements AppInfoRepository {
  final PackageInfoProvider _packageInfoProvider;

  const AppInfoRepositoryI(this._packageInfoProvider);

  @override
  Result<AppInfoEntity> info() {
    try {
      final data = AppInfoModel(
        installTime: _packageInfoProvider.installTime,
        updateTime: _packageInfoProvider.updateTime,
        version: _packageInfoProvider.version,
        number: int.parse(_packageInfoProvider.number),
        name: _packageInfoProvider.name,
        id: _packageInfoProvider.id,
      );

      return ResultSuccess(data);
    } catch (e) {
      return ResultFailure.fromObject(e);
    }
  }
}
