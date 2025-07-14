import '../providers/on_audio_query_provider.dart';

interface class PermissionsRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;

  const PermissionsRepository({
    required OnAudioQueryProvider onAudioQueryProvider,
  }) : _onAudioQueryProvider = onAudioQueryProvider;

  Future<bool> requestMediaPermission() {
    return _onAudioQueryProvider.permissionRequest();
  }

  Future<bool> getMediaPermission() {
    return _onAudioQueryProvider.permissionStatus();
  }
}
