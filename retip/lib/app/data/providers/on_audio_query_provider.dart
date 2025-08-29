import 'package:on_audio_query/on_audio_query.dart';

class OnAudioQueryProvider {
  final OnAudioQuery _onAudioQuery;

  OnAudioQueryProvider._(this._onAudioQuery);

  static Future<OnAudioQueryProvider> init() async {
    final onAudioQuery = OnAudioQuery();

    return OnAudioQueryProvider._(onAudioQuery);
  }

  Future<bool> requestPermissions() async {
    var hasPermission = await _onAudioQuery.permissionsStatus();

    if (!hasPermission) {
      hasPermission = await _onAudioQuery.permissionsRequest();
    }

    return hasPermission;
  }

  Future<bool> checkPermissions() async {
    return await _onAudioQuery.permissionsStatus();
  }

  Future<List<SongModel>> querySongs() async {
    return await _onAudioQuery.querySongs();
  }
}
