import 'package:get_it/get_it.dart';
import 'package:retip/app/domain/entities/album_entity.dart';
import 'package:retip/app/domain/repositories/library_repository.dart';

mixin GetAllAlbums {
  static Future<List<AlbumEntity>> call() async {
    return GetIt.I.get<LibraryRepository>().getAllAlbums();
  }
}
