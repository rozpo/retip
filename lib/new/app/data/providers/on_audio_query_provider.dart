import 'package:on_audio_query/on_audio_query.dart';

import '../models/track_model.dart';

class OnAudioQueryProvider {
  final OnAudioQuery _onAudioQuery;

  const OnAudioQueryProvider({
    required OnAudioQuery onAudioQuery,
  }) : _onAudioQuery = onAudioQuery;

  Future<List<TrackModel>> getTracks() async {
    final data = await _onAudioQuery.querySongs();

    final tracks = <TrackModel>[];
    for (final track in data) {
      if (track.uri == null) continue;

      final entity = TrackModel(
        artist: track.artist ?? 'Unknown',
        album: track.album ?? 'Unknown',
        title: track.title,
        location: track.uri!,
      );

      tracks.add(entity);
    }

    return tracks;
  }
}
