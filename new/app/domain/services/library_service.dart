import '../../data/repositories/album_repository.dart';
import '../../data/repositories/artist_repository.dart';
import '../../data/repositories/genre_repository.dart';
import '../../data/repositories/playlist_repository.dart';
import '../../data/repositories/track_repository.dart';
import '../entites/album_entity.dart';
import '../entites/artist_entity.dart';
import '../entites/genre_entity.dart';
import '../entites/playlist_entity.dart';
import '../entites/track_entity.dart';

interface class LibraryService {
  final PlaylistRepository _playlistRepository;
  final ArtistRepository _artistRepository;
  final AlbumRepository _albumRepository;
  final GenreRepository _genreRepository;
  final TrackRepository _trackRepository;

  const LibraryService({
    required PlaylistRepository playlistRepository,
    required ArtistRepository artistRepository,
    required AlbumRepository albumRepository,
    required GenreRepository genreRepository,
    required TrackRepository trackRepository,
  })  : _playlistRepository = playlistRepository,
        _artistRepository = artistRepository,
        _albumRepository = albumRepository,
        _genreRepository = genreRepository,
        _trackRepository = trackRepository;

  Future<int> scan() async {
    final futures = await Future.wait<int>([
      _genreRepository.cacheAll(),
      _artistRepository.cacheAll(),
      _trackRepository.cacheAll(),
      _albumRepository.cacheAll(),
    ]);

    return futures.reduce((value, element) => value + element);
  }

  Stream<List<GenreEntity>> watchGenres() {
    return _genreRepository.watchAll();
  }

  Stream<List<ArtistEntity>> watchArtists() {
    return _artistRepository.watchAll();
  }

  Stream<List<AlbumEntity>> watchAlbums() {
    return _albumRepository.watchAll();
  }

  Stream<List<TrackEntity>> watchTracks() {
    return _trackRepository.watchAll();
  }

  Stream<List<PlaylistEntity>> watchPlaylists() {
    return _playlistRepository.watchAll();
  }
}
