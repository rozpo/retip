import 'package:on_audio_query/on_audio_query.dart';

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

  Future<int> scan() async {
    final future = await Future.wait([
      _objectboxProvider.getAll<TrackModel>(),
      _onAudioQueryProvider.scanSongs(),
    ]);

    final cache = future[0] as List<TrackModel>;
    final data = future[1] as List<SongModel>;
    final ids = cache.map((e) => e.trackId);

    final newData = data.where((e) => ids.contains(e.id) == false).toList();
    final result = newData.map((e) => TrackModel.fromOnAudioQuery(e)).toList();

    await _objectboxProvider.putMany(result);

    return result.length;
  }

  Stream<List<TrackModel>> watchAll() {
    return _objectboxProvider.watchAll<TrackModel>();
  }
}
