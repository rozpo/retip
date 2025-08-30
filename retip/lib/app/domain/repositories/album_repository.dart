import '../entities/album_entity.dart';
import '../errors/result.dart';

/// Album repository interface
abstract interface class AlbumRepository {
  /// Stream all albums
  Result<Stream<List<AlbumEntity>>> streamAll();

  /// Scan for new albums, returning the number of albums added
  Future<Result<int>> scan();
}
