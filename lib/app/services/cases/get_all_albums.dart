import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/services/repositories/album_repository.dart';

class GetAllAlbums {
  final AlbumRepository repository;

  GetAllAlbums(this.repository);

  Future<List<AlbumEntity>> call() async {
    return repository.getAll();
  }
}
