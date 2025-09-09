import 'package:retip/app/domain/enitities/artist_entity.dart';
import 'package:retip/app/domain/errors/result.dart';

abstract interface class ArtistRepository {
  Future<Result<List<ArtistEntity>>> getAll();
}
