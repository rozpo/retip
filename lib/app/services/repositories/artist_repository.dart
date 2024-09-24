import 'package:retip/app/services/entities/artist_entity.dart';

abstract class ArtistRepository {
  Future<List<ArtistEntity>> getAll();
}
