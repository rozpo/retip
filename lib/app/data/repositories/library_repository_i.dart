import '../../../objectbox.g.dart';
import '../../domain/repositories/library_repository.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/genre_model.dart';
import '../models/track_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

class LibraryRepositoryI implements LibraryRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  LibraryRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  })  : _onAudioQueryProvider = onAudioQueryProvider,
        _objectboxProvider = objectboxProvider;

  @override
  Future<int> scan() async {
    final permissionStatus = await _onAudioQueryProvider.permissionStatus();

    if (permissionStatus == false) {
      final permissionRequest = await _onAudioQueryProvider.permissionRequest();

      if (permissionRequest == false) {
        // Create custom exception
        throw Exception('Permission denied');
      }
    }

    await _scanArtists();
    await _scanAlbums();
    await _scanGenres();
    return await _scanTracks();
  }

  Future<int> _scanTracks() async {
    final tracks = await _onAudioQueryProvider.querySongs();
    int count = 0;

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
      count++;
    }

    return count;
  }

  Future<void> _scanAlbums() async {
    final albums = await _onAudioQueryProvider.queryAlbums();
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

  Future<void> _scanArtists() async {
    final artists = await _onAudioQueryProvider.queryArtists();

    for (final artist in artists) {
      final condition = ArtistModel_.name.equals(artist.artist);
      final entity = await _objectboxProvider.findFirst<ArtistModel>(condition);

      if (entity != null) continue;

      final artistEntity = ArtistModel(name: artist.artist);
      _objectboxProvider.insert<ArtistModel>(artistEntity);
    }
  }

  Future<void> _scanGenres() async {
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
