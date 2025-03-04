import '../../domain/repositories/settings_repository.dart';
import '../providers/app_settings_provider.dart';

class SettingsRepositoryI implements SettingsRepository {
  final AppSettingsProvider _appSettingsProvider;

  SettingsRepositoryI({
    required AppSettingsProvider appSettingsProvider,
  }) : _appSettingsProvider = appSettingsProvider;

  @override
  Future<void> openAppSettings() async {
    return await _appSettingsProvider.openAppSettings();
  }
}
