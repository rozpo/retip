import 'package:on_audio_query/on_audio_query.dart';

final class OnAudioQueryProvider {
  final OnAudioQuery _onAudioQuery;

  static Future<OnAudioQueryProvider> init() async {
    return OnAudioQueryProvider._(OnAudioQuery());
  }

  const OnAudioQueryProvider._(this._onAudioQuery);

  Future<List<SongModel>> scanSongs() async {
    return await _onAudioQuery.querySongs();
  }
}
