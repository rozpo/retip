import '../../domain/repositories/permission_repository.dart';
import '../providers/on_audio_query_provider.dart';

class PermissionRepositoryImplementation implements PermissionRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;

  PermissionRepositoryImplementation({
    required OnAudioQueryProvider onAudioQueryProvider,
  }) : _onAudioQueryProvider = onAudioQueryProvider;

  @override
  Future<bool> storagePermissionRequest() async {
    return await _onAudioQueryProvider.permissionsRequest();
  }

  @override
  Future<bool> storagePermissionStatus() async {
    return await _onAudioQueryProvider.permissionsStatus();
  }
}
