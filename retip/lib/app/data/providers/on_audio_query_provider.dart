import 'package:on_audio_query/on_audio_query.dart';

class OnAudioQueryProvider {
  final OnAudioQuery _onAudioQuery;

  const OnAudioQueryProvider._(this._onAudioQuery);

  static Future<OnAudioQueryProvider> init() async {
    return OnAudioQueryProvider._(OnAudioQuery());
  }

  Future<bool> permissionsCheck() async {
    return await _onAudioQuery.permissionsStatus();
  }

  Future<bool> permissionsRequest() async {
    return await _onAudioQuery.permissionsRequest();
  }

  Future<List<SongModel>> getSongs() async {
    return await _onAudioQuery.querySongs();
  }
}
