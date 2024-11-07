import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/services/repositories/library_repository.dart';

mixin GetAlbum {
  static Future<AlbumEntity> call(int id) async {
    return await GetIt.I.get<LibraryRepository>().getAlbum(id);
  }
}
