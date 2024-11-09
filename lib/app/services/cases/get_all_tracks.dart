import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/services/repositories/library_repository.dart';

class GetAllTracks {
  static Future<List<TrackEntity>> call() async {
    return await GetIt.I.get<LibraryRepository>().getAllTracks();
  }
}
