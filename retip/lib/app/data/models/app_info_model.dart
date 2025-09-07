import '../../domain/enitities/app_info_entity.dart';

final class AppInfoModel extends AppInfoEntity {
  const AppInfoModel({
    required super.installTime,
    required super.updateTime,
    required super.version,
    required super.number,
    required super.name,
    required super.id,
  });
}
