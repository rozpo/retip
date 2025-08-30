import 'package:retip/app/data/models/album_model.dart';
import 'package:retip/app/data/providers/objectbox/objectbox_provider.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/domain/entities/album_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/album_repository.dart';

final class AlbumRepositoryI implements AlbumRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  AlbumRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  }) : _onAudioQueryProvider = onAudioQueryProvider,
       _objectboxProvider = objectboxProvider;

  @override
  Future<Result<int>> scan() async {
    try {
      final albumsOnDevice = await _onAudioQueryProvider.queryAlbums();
      final albumsInDb = await _objectboxProvider.getAll<AlbumModel>();

      final albumsInDbIds = albumsInDb.map((album) => album.albumId);
      final newAlbums = <AlbumModel>[];

      for (final album in albumsOnDevice) {
        if (albumsInDbIds.contains(album.id) == false) {
          newAlbums.add(
            AlbumModel(
              artist: album.artist!,
              title: album.album,
              albumId: album.id,
            ),
          );
        }
      }

      final ids = await _objectboxProvider.insertMany(newAlbums);

      return ResultSuccess(ids.length);
    } catch (e) {
      return ResultFailure(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Result<Stream<List<AlbumEntity>>> streamAll() {
    try {
      return ResultSuccess(_objectboxProvider.streamAll<AlbumModel>());
    } catch (e) {
      return ResultFailure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
