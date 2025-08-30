import 'package:retip/app/data/models/album_model.dart';
import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/data/providers/objectbox/objectbox_provider.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/library_repository.dart';

final class LibraryRepositoryI implements LibraryRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  const LibraryRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  }) : _onAudioQueryProvider = onAudioQueryProvider,
       _objectboxProvider = objectboxProvider;

  @override
  Future<Result<int>> scan() async {
    try {
      final deviceAlbums = await _onAudioQueryProvider.queryAlbums();
      final deviceTracks = await _onAudioQueryProvider.querySongs();

      final dbAlbums = await _objectboxProvider.getAll<AlbumModel>();
      final dbTracks = await _objectboxProvider.getAll<TrackModel>();

      final dbAlbumIds = dbAlbums.map((album) => album.albumId);
      final dbTrackIds = dbTracks.map((track) => track.trackId);

      final newAlbums = <AlbumModel>[];
      final newTracks = <TrackModel>[];

      for (final album in deviceAlbums) {
        if (dbAlbumIds.contains(album.id) == false) {
          newAlbums.add(
            AlbumModel(
              artist: album.artist!,
              title: album.album,
              albumId: album.id,
            ),
          );
        }
      }

      for (final track in deviceTracks) {
        if (dbTrackIds.contains(track.id) == false) {
          newTracks.add(
            TrackModel(
              albumId: track.albumId,
              artist: track.artist!,
              title: track.title,
              trackId: track.id,
            ),
          );
        }
      }

      final newAlbumsIds = await _objectboxProvider.insertMany(newAlbums);
      final newTracksIds = await _objectboxProvider.insertMany(newTracks);

      return ResultSuccess(newAlbumsIds.length + newTracksIds.length);
    } catch (e) {
      return ResultFailure(e is Exception ? e : Exception(e));
    }
  }
}
