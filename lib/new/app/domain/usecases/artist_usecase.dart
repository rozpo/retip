import '../entities/artist_entity.dart';
import '../repositories/artist_repository.dart';

class ArtistUsecase {
  final ArtistRepository _artistRepository;

  const ArtistUsecase({
    required ArtistRepository albumRepository,
  }) : _artistRepository = albumRepository;

  Stream<List<ArtistEntity>> allStream() {
    return _artistRepository.allStream();
  }

  Stream<ArtistEntity?> byIdStream(int id) {
    return _artistRepository.byIdStream(id);
  }
}
