import '../entities/album_entity.dart';

abstract class AlbumRepository {
  Stream<List<AlbumEntity>> stream();

  void toggleFavorite(AlbumEntity album);

  Stream<AlbumEntity?> albumStream(int id);
}
