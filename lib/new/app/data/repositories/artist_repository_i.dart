import '../../../../objectbox.g.dart';
import '../../domain/repositories/artist_repository.dart';
import '../models/artist_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

class ArtistRepositoryI implements ArtistRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  const ArtistRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  })  : _onAudioQueryProvider = onAudioQueryProvider,
        _objectboxProvider = objectboxProvider;

  @override
  Stream<List<ArtistModel>> allStream() {
    return _objectboxProvider.stream<ArtistModel>();
  }

  @override
  Stream<ArtistModel?> byIdStream(int id) {
    final condition = ArtistModel_.id.equals(id);
    return _objectboxProvider.stream<ArtistModel>(condition).map((event) {
      if (event.isEmpty) return null;
      return event.first;
    });
  }

  @override
  Future<void> scan() async {
    final artists = await _onAudioQueryProvider.getAllArtists();

    for (final artist in artists) {
      final condition = ArtistModel_.name.equals(artist.artist);
      final entity = await _objectboxProvider.findFirst<ArtistModel>(condition);

      if (entity != null) continue;

      final artistEntity = ArtistModel(name: artist.artist);
      _objectboxProvider.insert<ArtistModel>(artistEntity);
    }
  }
}
