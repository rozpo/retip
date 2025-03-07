import '../entities/album_entity.dart';

abstract class AlbumRepository {
  Stream<List<AlbumEntity>> stream();

  void toggleFavorite(AlbumEntity track);

  Stream<AlbumEntity?> trackStream(int id);
}
