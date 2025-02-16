import '../../../../app/data/providers/on_audio_query_provider.dart';
import '../../../../app/data/providers/shared_preferences_provider.dart';
import '../../domain/repositories/permission_repository.dart';

class PermissionRepositoryI implements PermissionRepository {
  final SharedPreferencesProvider _sharedPreferencesProvider;
  final OnAudioQueryProvider _onAudioQueryProvider;

  PermissionRepositoryI({
    required SharedPreferencesProvider sharedPreferencesProvider,
    required OnAudioQueryProvider onAudioQueryProvider,
  })  : _sharedPreferencesProvider = sharedPreferencesProvider,
        _onAudioQueryProvider = onAudioQueryProvider;

  @override
  Future<bool> check() async {
    final storedPermission = _sharedPreferencesProvider.getBool('permission');
    if (storedPermission) {
      return storedPermission;
    } else {
      return await _onAudioQueryProvider.permissionsStatus();
    }
  }

  @override
  Future<bool> request() async {
    final result = await _onAudioQueryProvider.permissionsRequest();
    _sharedPreferencesProvider.setBool('permission', result);

    return result;
  }
}
