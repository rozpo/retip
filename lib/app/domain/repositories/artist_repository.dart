import '../entities/artist_entity.dart';

abstract class ArtistRepository {
  Stream<List<ArtistEntity>> stream();

  void toggleFavorite(ArtistEntity artist);

  Stream<ArtistEntity?> artistStream(int id);
}
