import 'package:retip/app/services/entities/album_entity.dart';

abstract class AlbumRepository {
  Future<List<AlbumEntity>> getAll();
}
