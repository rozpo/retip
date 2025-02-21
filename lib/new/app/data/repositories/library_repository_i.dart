import '../../../../objectbox.g.dart';
import '../../domain/entities/album_entity.dart';
import '../../domain/entities/artist_entity.dart';
import '../../domain/entities/genre_entity.dart';
import '../../domain/entities/track_entity.dart';
import '../../domain/repositories/library_repository.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/genre_model.dart';
import '../models/track_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

class LibraryRepositoryI implements LibraryRepository {
  final ObjectboxProvider _objectboxProvider;
  final OnAudioQueryProvider _onAudioQueryProvider;

  const LibraryRepositoryI({
    required ObjectboxProvider objectboxProvider,
    required OnAudioQueryProvider onAudioQueryProvider,
  })  : _objectboxProvider = objectboxProvider,
        _onAudioQueryProvider = onAudioQueryProvider;

  @override
  Future<void> scan() async {
    final albums = await _onAudioQueryProvider.getAllAlbums();
    final artists = await _onAudioQueryProvider.getAllArtists();
    final genres = await _onAudioQueryProvider.getAllGenres();

    for (final artist in artists) {
      final condition = ArtistModel_.name.equals(artist.artist);
      final entity = await _objectboxProvider.findFirst<ArtistModel>(condition);

      if (entity != null) continue;

      final artistEntity = ArtistModel(name: artist.artist);
      _objectboxProvider.insert<ArtistModel>(artistEntity);
    }

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

    for (final genre in genres) {
      final condition = GenreModel_.name.equals(genre.genre);
      final entity = await _objectboxProvider.findFirst<GenreModel>(condition);

      if (entity != null) continue;

      final genreEntity = GenreModel(name: genre.genre);
      _objectboxProvider.insert<GenreModel>(genreEntity);
    }
  }

  @override
  Stream<List<TrackEntity>> tracksStream() {
    return _objectboxProvider.stream<TrackModel>();
  }

  @override
  Stream<List<AlbumEntity>> albumsStream() {
    return _objectboxProvider.stream<AlbumModel>();
  }

  @override
  Stream<List<ArtistEntity>> artistsStream() {
    return _objectboxProvider.stream<ArtistModel>();
  }

  @override
  Stream<List<GenreEntity>> genresStream() {
    return _objectboxProvider.stream<GenreModel>();
  }
}
