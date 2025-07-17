import 'package:on_audio_query/on_audio_query.dart';

import '../../../objectbox.g.dart';
import '../../domain/entites/track_entity.dart';
import '../models/track_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

interface class TrackRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  const TrackRepository({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  })  : _onAudioQueryProvider = onAudioQueryProvider,
        _objectboxProvider = objectboxProvider;

  Future<int> cacheAll() async {
    final futures = await Future.wait([
      _onAudioQueryProvider.querySongs(),
      _objectboxProvider.getAll<TrackModel>(),
    ]);

    final data = futures[0] as List<SongModel>;
    final cache = futures[1] as List<TrackEntity>;
    final cacheIds = cache.map((e) => e.trackId);

    data.removeWhere((e) => cacheIds.contains(e.id));
    final entities = data.map((e) => TrackModel.fromOnAudioQuery(e)).toList();

    final list = await _objectboxProvider.insertMany<TrackModel>(entities);

    return list.length;
  }

  Stream<List<TrackEntity>> watchAll() {
    return _objectboxProvider.watchAll<TrackModel>();
  }

  Stream<List<TrackEntity>> watchByAlbum(int albumId) {
    final condition = TrackModel_.albumId.equals(albumId);
    return _objectboxProvider.watchWhere<TrackModel>(condition);
  }
}
