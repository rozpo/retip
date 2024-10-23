import 'dart:typed_data';

import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/services/repositories/track_repository.dart';

class OnAudioQueryTrackRepository implements TrackRepository {
  final _onAudioQueryProvider = OnAudioQueryProvider();

  @override
  Future<List<TrackModel>> getAll() async {
    final data = await _onAudioQueryProvider.getAllTracks();

    final artworks = <int, Uint8List>{};
    final tracks = <TrackModel>[];

    for (final track in data) {
      final albumId = track.albumId;
      Uint8List? artwork;

      if (albumId != null) {
        if (artworks.containsKey(albumId)) {
          artwork = artworks[albumId];
        } else {
          artwork = await _onAudioQueryProvider.getAudioArtwork(track.id);

          if (artwork != null) {
            artworks.addAll({albumId: artwork});
          }
        }
      }

      tracks.add(TrackModel.fromSongModel(track, artwork));
    }

    return tracks;
  }
}
