import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/services/repositories/track_repository.dart';

class OnAudioQueryTrackRepository implements TrackRepository {
  final _onAudioQueryProvider = OnAudioQueryProvider();

  @override
  Future<List<TrackEntity>> getAll() async {
    final data = await _onAudioQueryProvider.getAllTracks();
    final tracks = <TrackModel>[];

    for (final element in data) {
      final artwork = await _onAudioQueryProvider.getAudioArtwork(element.id);
      tracks.add(TrackModel.fromSongModel(element, artwork));
    }

    return tracks;
  }
}
