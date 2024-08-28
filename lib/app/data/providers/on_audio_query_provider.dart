import 'package:on_audio_query/on_audio_query.dart';

class OnAudioQueryProvider {
  final _onAudioQuery = OnAudioQuery();

  Future<List<SongModel>> getAllTracks() async {
    return await _onAudioQuery.querySongs();
  }
}
