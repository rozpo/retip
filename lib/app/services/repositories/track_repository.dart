import 'package:retip/app/services/entities/track_entity.dart';

abstract class TrackRepository {
  Future<List<TrackEntity>> getAll();
}
