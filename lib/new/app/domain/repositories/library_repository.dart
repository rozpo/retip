import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../objectbox.g.dart';
import '../../data/models/track_model.dart';

class LibraryRepository {
  Future<void> scan() async {
    final onAudioQuery = OnAudioQuery();
    final objectbox = GetIt.I.get<Store>();

    final tracks = await onAudioQuery.querySongs();

    final tracksBox = objectbox.box<TrackModel>();
    for (final track in tracks) {
      if (track.uri == null) continue;

      final entity = await tracksBox
          .query(TrackModel_.location.equals(track.uri!))
          .build()
          .findFirstAsync();

      if (entity == null) {
        final entity = TrackModel(
          artist: track.artist ?? 'Unknown',
          album: track.album ?? 'Unknown',
          title: track.title,
          location: track.uri!,
        );

        tracksBox.putAsync(entity);
      }
    }
  }
}
