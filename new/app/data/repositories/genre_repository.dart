import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;

import '../../domain/entites/genre_entity.dart';
import '../models/genre_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

interface class GenreRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  const GenreRepository({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  })  : _onAudioQueryProvider = onAudioQueryProvider,
        _objectboxProvider = objectboxProvider;

  Future<int> cacheAll() async {
    final futures = await Future.wait([
      _onAudioQueryProvider.queryGenres(),
      _objectboxProvider.getAll<GenreModel>(),
    ]);

    final data = futures[0] as List<on_audio_query.GenreModel>;
    final cache = futures[1] as List<GenreEntity>;
    final cacheIds = cache.map((e) => e.genreId);

    data.removeWhere((e) => cacheIds.contains(e.id));
    final entities = data.map((e) => GenreModel.fromOnAudioQuery(e)).toList();

    final list = await _objectboxProvider.insertMany<GenreModel>(entities);

    return list.length;
  }

  Stream<List<GenreEntity>> watchAll() {
    return _objectboxProvider.watchAll<GenreModel>();
  }
}
