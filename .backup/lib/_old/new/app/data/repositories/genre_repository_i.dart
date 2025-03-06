import '../../../../objectbox.g.dart';
import '../../domain/repositories/genre_repository.dart';
import '../../../../../../../last/app/data/models/genre_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

class GenreRepositoryI implements GenreRepository {
  final ObjectboxProvider _objectboxProvider;
  final OnAudioQueryProvider _onAudioQueryProvider;

  const GenreRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  })  : _onAudioQueryProvider = onAudioQueryProvider,
        _objectboxProvider = objectboxProvider;

  @override
  Stream<List<GenreModel>> allStream() {
    return _objectboxProvider.stream<GenreModel>();
  }

  @override
  Stream<GenreModel?> byIdStream(int id) {
    final condition = GenreModel_.id.equals(id);
    return _objectboxProvider.stream<GenreModel>(condition).map((event) {
      if (event.isEmpty) return null;
      return event.first;
    });
  }

  @override
  Future<void> scan() async {
    final genres = await _onAudioQueryProvider.queryGenres();
    for (final genre in genres) {
      final condition = GenreModel_.name.equals(genre.genre);
      final entity = await _objectboxProvider.findFirst<GenreModel>(condition);

      if (entity != null) continue;

      final genreEntity = GenreModel(name: genre.genre);
      _objectboxProvider.insert<GenreModel>(genreEntity);
    }
  }
}
