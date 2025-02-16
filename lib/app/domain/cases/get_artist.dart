import 'package:get_it/get_it.dart';
import '../entities/artist_entity.dart';
import '../repositories/library_repository.dart';

mixin GetArtist {
  static Future<ArtistEntity> call(int id) async {
    return await GetIt.I.get<LibraryRepository>().getArtist(id);
  }
}
