import 'package:retip/app/data/models/album_model.dart';
import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/services/repositories/album_repository.dart';

class OnAudioQueryAlbumRepository implements AlbumRepository {
  final _onAudioQueryProvider = OnAudioQueryProvider();

  @override
  Future<List<AlbumModel>> getAll() async {
    final data = await _onAudioQueryProvider.getAllAlbums();
    final albums = <AlbumModel>[];

    final tracks = await _onAudioQueryProvider.getAllTracks();

    for (final album in data) {
      final albumArtwork =
          await _onAudioQueryProvider.getAlbumArtwork(album.id);
      final albumTracks = tracks
          .where((e) => e.album == album.album)
          .map((e) => TrackModel.fromSongModel(e, albumArtwork))
          .toList();

      albums.add(AlbumModel.fromAlbumModel(album, albumArtwork, albumTracks));
    }

    return albums;
  }
}
