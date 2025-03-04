import '../../domain/repositories/permission_repository.dart';
import '../providers/on_audio_query_provider.dart';

class PermissionRepositoryI implements PermissionRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;

  PermissionRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
  }) : _onAudioQueryProvider = onAudioQueryProvider;

  bool isPermissionGranted = false;

  @override
  Future<bool> getMediaPermissionStatus() async {
    if (isPermissionGranted == false) {
      isPermissionGranted = await _onAudioQueryProvider.permissionStatus();
    }

    return isPermissionGranted;
  }

  @override
  Future<bool> requestMediaPermission() async {
    return await _onAudioQueryProvider.permissionRequest();
  }
}
