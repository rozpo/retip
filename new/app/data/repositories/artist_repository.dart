import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;

import '../../domain/entites/artist_entity.dart';
import '../models/artist_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

interface class ArtistRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  const ArtistRepository({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  })  : _onAudioQueryProvider = onAudioQueryProvider,
        _objectboxProvider = objectboxProvider;

  Future<int> cacheAll() async {
    final futures = await Future.wait([
      _onAudioQueryProvider.queryArtists(),
      _objectboxProvider.getAll<ArtistModel>(),
    ]);

    final data = futures[0] as List<on_audio_query.ArtistModel>;
    final cache = futures[1] as List<ArtistEntity>;
    final cacheIds = cache.map((e) => e.artistId);

    data.removeWhere((e) => cacheIds.contains(e.id));
    final entities = data.map((e) => ArtistModel.fromOnAudioQuery(e)).toList();

    final list = await _objectboxProvider.insertMany<ArtistModel>(entities);

    return list.length;
  }

  Stream<List<ArtistEntity>> watchAll() {
    return _objectboxProvider.watchAll<ArtistModel>();
  }
}
