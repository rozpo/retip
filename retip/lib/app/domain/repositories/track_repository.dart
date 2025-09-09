import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/errors/result.dart';

abstract interface class TrackRepository {
  Future<Result<List<TrackEntity>>> getAll();

  Future<Result<List<TrackEntity>>> getByAlbum(int id);

  Future<Result<List<TrackEntity>>> getByArtist(int id);
}
