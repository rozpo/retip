import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;

import '../../../objectbox.g.dart';
import '../../domain/entites/album_entity.dart';
import '../models/album_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

interface class AlbumRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  const AlbumRepository({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  })  : _onAudioQueryProvider = onAudioQueryProvider,
        _objectboxProvider = objectboxProvider;

  Future<int> cacheAll() async {
    final futures = await Future.wait([
      _onAudioQueryProvider.queryAlbums(),
      _objectboxProvider.getAll<AlbumModel>(),
    ]);

    final data = futures[0] as List<on_audio_query.AlbumModel>;
    final cache = futures[1] as List<AlbumEntity>;
    final cacheIds = cache.map((e) => e.albumId);

    data.removeWhere((e) => cacheIds.contains(e.id));
    final entities = data.map((e) => AlbumModel.fromOnAudioQuery(e)).toList();

    final list = await _objectboxProvider.insertMany<AlbumModel>(entities);

    return list.length;
  }

  Stream<List<AlbumEntity>> watchAll() {
    return _objectboxProvider.watchAll<AlbumModel>();
  }

  Stream<AlbumEntity> watchById(int albumId) {
    final condition = AlbumModel_.albumId.equals(albumId);

    return _objectboxProvider.watchWhereFirst<AlbumModel>(condition);
  }
}
