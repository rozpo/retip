import '../../../../objectbox.g.dart';
import '../../domain/entities/album_entity.dart';
import '../../domain/repositories/album_repository.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

class AlbumRepositoryI implements AlbumRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  const AlbumRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  })  : _onAudioQueryProvider = onAudioQueryProvider,
        _objectboxProvider = objectboxProvider;

  @override
  Stream<List<AlbumEntity>> allStream() {
    // TODO: implement allStream
    throw UnimplementedError();
  }

  @override
  Stream<List<AlbumEntity>> byArtistStream(int artistId) {
    // TODO: implement byArtistStream
    throw UnimplementedError();
  }

  @override
  Stream<AlbumEntity?> byIdStream(int id) {
    // TODO: implement byIdStream
    throw UnimplementedError();
  }

  @override
  Future<void> scan() async {
    final albums = await _onAudioQueryProvider.getAllAlbums();
    for (final album in albums) {
      final condition = AlbumModel_.title.equals(album.album);
      final entity = await _objectboxProvider.findFirst<AlbumModel>(condition);

      if (entity != null) continue;

      final albumEntity = AlbumModel(
        title: album.album,
      );

      if (album.artist != null) {
        final artistCondition = ArtistModel_.name.equals(album.artist!);
        final artistEntity =
            await _objectboxProvider.findFirst<ArtistModel>(artistCondition);

        albumEntity.artistDb.target = artistEntity;
      }

      _objectboxProvider.insert<AlbumModel>(albumEntity);
    }
  }
}
