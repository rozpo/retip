import 'package:on_audio_query/on_audio_query.dart';

class OnAudioQueryProvider {
  final OnAudioQuery _onAudioQuery;

  OnAudioQueryProvider(OnAudioQuery onAudioQuery)
      : _onAudioQuery = onAudioQuery;

  static Future<OnAudioQueryProvider> init() async {
    final onAudioQuery = OnAudioQuery();
    return OnAudioQueryProvider(onAudioQuery);
  }

  Future<bool> permissionRequest() async {
    return await _onAudioQuery.permissionsRequest();
  }

  Future<bool> permissionStatus() async {
    return await _onAudioQuery.permissionsStatus();
  }

  Future<List<SongModel>> querySongs() async {
    return await _onAudioQuery.querySongs();
  }
}
