import '../../../../../../../last/app/domain/entities/album_entity.dart';

abstract class AlbumRepository {
  Future<void> scan();

  Stream<List<AlbumEntity>> allStream();

  Stream<List<AlbumEntity>> byArtistStream(int artistId);

  Stream<AlbumEntity?> byIdStream(int id);
}
