import '../../domain/repositories/permission_repository.dart';
import '../providers/app_settings_provider.dart';
import '../providers/on_audio_query_provider.dart';

class PermissionRepositoryI implements PermissionRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final AppSettingsProvider _appSettingsProvider;

  const PermissionRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
    required AppSettingsProvider appSettingsProvider,
  })  : _onAudioQueryProvider = onAudioQueryProvider,
        _appSettingsProvider = appSettingsProvider;

  @override
  Future<bool> askForMediaPermission() async {
    return await _onAudioQueryProvider.permissionsRequest();
  }

  @override
  Future<bool> hasMediaPermission() async {
    return await _onAudioQueryProvider.permissionsStatus();
  }

  @override
  Future<void> openAppSettings() async {
    await _appSettingsProvider.openAppSettings();
  }
}
