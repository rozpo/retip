import 'package:get_it/get_it.dart';
import '../entities/album_entity.dart';
import '../repositories/library_repository.dart';

mixin GetAllAlbums {
  static Future<List<AlbumEntity>> call() async {
    return GetIt.I.get<LibraryRepository>().getAllAlbums();
  }
}
