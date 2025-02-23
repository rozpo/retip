import '../repositories/album_repository.dart';
import '../repositories/artist_repository.dart';
import '../repositories/genre_repository.dart';
import '../repositories/track_repository.dart';

class LibraryUsecase {
  final ArtistRepository _artistRepository;
  final AlbumRepository _albumRepository;
  final GenreRepository _genreRepository;
  final TrackRepository _trackRepository;

  LibraryUsecase({
    required ArtistRepository artistRepository,
    required AlbumRepository albumRepository,
    required GenreRepository genreRepository,
    required TrackRepository trackRepository,
  })  : _artistRepository = artistRepository,
        _albumRepository = albumRepository,
        _genreRepository = genreRepository,
        _trackRepository = trackRepository;

  Future<void> scan() async {
    await _artistRepository.scan();
    await _albumRepository.scan();
    await _genreRepository.scan();
    await _trackRepository.scan();
  }
}
