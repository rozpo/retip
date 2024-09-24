import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/repositories/artist_repository.dart';

class GetAllArtists {
  final ArtistRepository repository;

  GetAllArtists(this.repository);

  Future<List<ArtistEntity>> call() async {
    return repository.getAll();
  }
}
