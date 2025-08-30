import '../entities/track_entity.dart';
import '../errors/result.dart';

/// Track repository interface
abstract interface class TrackRepository {
  /// Stream all tracks
  Result<Stream<List<TrackEntity>>> streamAll();

  /// Scan and add new tracks, returning the number of tracks added
  Future<Result<int>> scan();
}
