import 'package:get_it/get_it.dart';
import '../entities/track_entity.dart';
import '../repositories/library_repository.dart';

class GetAllTracks {
  static Future<List<TrackEntity>> call() async {
    return await GetIt.I.get<LibraryRepository>().getAllTracks();
  }
}
