import 'package:on_audio_query/on_audio_query.dart';

class OnAudioQueryProvider {
  final _onAudioQuery = OnAudioQuery();

  Future<List<SongModel>> getAllTracks() async {
    if (await _onAudioQuery.checkAndRequest() == false) {
      return [];
    }

    return await _onAudioQuery.querySongs();
  }
}
