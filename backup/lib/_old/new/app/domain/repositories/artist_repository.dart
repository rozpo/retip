import '../../../../../../../last/app/domain/entities/artist_entity.dart';

abstract class ArtistRepository {
  Future<void> scan();

  Stream<List<ArtistEntity>> allStream();

  Stream<ArtistEntity?> byIdStream(int id);
}
