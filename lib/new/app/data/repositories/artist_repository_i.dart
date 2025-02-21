import '../../../../objectbox.g.dart';
import '../../domain/entities/artist_entity.dart';
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
  Stream<List<ArtistEntity>> allStream() {
    // TODO: implement allStream
    throw UnimplementedError();
  }

  @override
  Stream<ArtistEntity?> byIdStream(int id) {
    // TODO: implement byIdStream
    throw UnimplementedError();
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
