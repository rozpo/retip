import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/errors/result.dart';

abstract interface class TrackRepository {
  Future<Result<List<TrackEntity>>> getAll();
}
