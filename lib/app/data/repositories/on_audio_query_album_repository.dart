import 'package:retip/app/data/models/album_model.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/services/repositories/album_repository.dart';

class OnAudioQueryAlbumRepository implements AlbumRepository {
  final _onAudioQueryProvider = OnAudioQueryProvider();

  @override
  Future<List<AlbumEntity>> getAll() async {
    final data = await _onAudioQueryProvider.getAllAlbums();
    final albums = <AlbumModel>[];

    for (final element in data) {
      final artwork = await _onAudioQueryProvider.getAudioArtwork(element.id);
      albums.add(AlbumModel.fromSongModel(element, artwork));
    }

    return albums;
  }
}
