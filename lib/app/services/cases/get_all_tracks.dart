import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/services/repositories/track_repository.dart';

class GetAllTracks {
  final TrackRepository repository;

  GetAllTracks(this.repository);

  Future<List<TrackEntity>> call() async {
    return repository.getAll();
  }
}
