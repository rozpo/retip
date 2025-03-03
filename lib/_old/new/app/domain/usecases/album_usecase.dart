import '../../../../../app/domain/entities/album_entity.dart';
import '../repositories/album_repository.dart';

class AlbumUsecase {
  final AlbumRepository _albumRepository;

  const AlbumUsecase({
    required AlbumRepository albumRepository,
  }) : _albumRepository = albumRepository;

  Stream<List<AlbumEntity>> allStream() {
    return _albumRepository.allStream();
  }

  Stream<List<AlbumEntity>> byArtistStream(int artistId) {
    return _albumRepository.byArtistStream(artistId);
  }

  Stream<AlbumEntity?> byIdStream(int id) {
    return _albumRepository.byIdStream(id);
  }
}
