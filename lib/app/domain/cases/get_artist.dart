import 'package:get_it/get_it.dart';
import 'package:retip/app/domain/entities/artist_entity.dart';
import 'package:retip/app/domain/repositories/library_repository.dart';

mixin GetArtist {
  static Future<ArtistEntity> call(int id) async {
    return await GetIt.I.get<LibraryRepository>().getArtist(id);
  }
}
