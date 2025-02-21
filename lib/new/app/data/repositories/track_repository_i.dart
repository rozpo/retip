import '../../../../objectbox.g.dart';
import '../../domain/repositories/track_repository.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/genre_model.dart';
import '../models/track_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

class TrackRepositoryI implements TrackRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  const TrackRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  })  : _onAudioQueryProvider = onAudioQueryProvider,
        _objectboxProvider = objectboxProvider;

  @override
  Stream<List<TrackModel>> allStream() {
    return _objectboxProvider.stream<TrackModel>();
  }

  @override
  Stream<List<TrackModel>> byAlbumStream(int albumId) {
    final condition = TrackModel_.albumDb.equals(albumId);
    return _objectboxProvider.stream<TrackModel>(condition);
  }

  @override
  Stream<List<TrackModel>> byArtistStream(int artistId) {
    final condition = TrackModel_.artistDb.equals(artistId);
    return _objectboxProvider.stream<TrackModel>(condition);
  }

  @override
  Stream<List<TrackModel>> byGenreStream(int genreId) {
    final condition = TrackModel_.genreDb.equals(genreId);
    return _objectboxProvider.stream<TrackModel>(condition);
  }

  @override
  Future<void> scan() async {
    final tracks = await _onAudioQueryProvider.getAllTracks();

    for (final track in tracks) {
      if (track.uri == null) continue;

      final condition = TrackModel_.location.equals(track.uri!);
      final entity = await _objectboxProvider.findFirst<TrackModel>(condition);

      if (entity != null) continue;

      final trackEntity = TrackModel(
        location: track.uri!,
        title: track.title,
      );

      if (track.album != null) {
        final albumCondition = AlbumModel_.title.equals(track.album!);
        final albumEntity =
            await _objectboxProvider.findFirst<AlbumModel>(albumCondition);

        trackEntity.albumDb.target = albumEntity;
      }

      if (track.artist != null) {
        final artistCondition = ArtistModel_.name.equals(track.artist!);
        final artistEntity =
            await _objectboxProvider.findFirst<ArtistModel>(artistCondition);

        trackEntity.artistDb.target = artistEntity;
      }

      if (track.genre != null) {
        final genreCondition = GenreModel_.name.equals(track.genre!);
        final genreEntity =
            await _objectboxProvider.findFirst<GenreModel>(genreCondition);

        trackEntity.genreDb.target = genreEntity;
      }

      _objectboxProvider.insert<TrackModel>(trackEntity);
    }
  }

  @override
  Future<void> toggleFavorite(int id) async {
    final entity = await _objectboxProvider.get<TrackModel>(id);

    if (entity == null) return;

    entity.isFavorite = !entity.isFavorite;
    _objectboxProvider.update<TrackModel>(entity);
  }
}
