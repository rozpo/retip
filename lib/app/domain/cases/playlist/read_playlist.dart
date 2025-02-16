import 'package:get_it/get_it.dart';
import '../get_all_tracks.dart';
import '../../entities/playlist_entity.dart';
import '../../entities/track_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin ReadPlaylist {
  static Map<int, TrackEntity>? tracksMap;

  static Future<PlaylistEntity?> call(String key) async {
    final prefs = GetIt.I.get<SharedPreferences>();

    final values = prefs.getStringList(key);

    if (values == null) {
      return null;
    }

    final trackIds = values.sublist(1).map((e) => int.parse(e)).toList();

    if (tracksMap == null) {
      final allTracks = await GetAllTracks.call();

      tracksMap ??= {
        for (final track in allTracks) track.id: track,
      };
    }

    final tracks = <TrackEntity>[];
    for (final trackId in trackIds) {
      tracks.add(tracksMap![trackId]!);
    }

    return PlaylistEntity(
      id: int.parse(key.split('_')[1]),
      name: values.first,
      tracks: tracks,
    );
  }
}
