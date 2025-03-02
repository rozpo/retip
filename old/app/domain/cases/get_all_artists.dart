import 'package:get_it/get_it.dart';
import '../entities/artist_entity.dart';
import '../repositories/library_repository.dart';

mixin GetAllArtists {
  static Future<List<ArtistEntity>> call() async {
    return GetIt.I.get<LibraryRepository>().getAllArtists();
  }
}
