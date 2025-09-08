import 'package:retip/app/domain/enitities/album_entity.dart';
import 'package:retip/app/domain/errors/result.dart';

abstract interface class AlbumRepository {
  Future<Result<List<AlbumEntity>>> getAll();
}
