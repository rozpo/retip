import '../../../../objectbox.g.dart';
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
  Stream<List<AlbumModel>> allStream() {
    return _objectboxProvider.stream<AlbumModel>();
  }

  @override
  Stream<List<AlbumModel>> byArtistStream(int artistId) {
    final condition = AlbumModel_.artistDb.equals(artistId);
    return _objectboxProvider.stream<AlbumModel>(condition);
  }

  @override
  Stream<AlbumModel?> byIdStream(int id) {
    final condition = AlbumModel_.id.equals(id);
    return _objectboxProvider.stream<AlbumModel>(condition).map((event) {
      if (event.isEmpty) return null;
      return event.first;
    });
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
