import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/data/providers/objectbox/objectbox_provider.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/domain/entities/track_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/track_repository.dart';

final class TrackRepositoryI implements TrackRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  TrackRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  }) : _onAudioQueryProvider = onAudioQueryProvider,
       _objectboxProvider = objectboxProvider;

  @override
  Future<Result<int>> scan() async {
    try {
      final tracksOnDevice = await _onAudioQueryProvider.querySongs();
      final tracksInDb = await _objectboxProvider.getAll<TrackModel>();

      final tracksInDbIds = tracksInDb.map((track) => track.trackId);
      final newTracks = <TrackModel>[];

      for (final track in tracksOnDevice) {
        if (tracksInDbIds.contains(track.id) == false) {
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

      final ids = await _objectboxProvider.insertMany(newTracks);

      return ResultSuccess(ids.length);
    } catch (e) {
      return ResultFailure(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Result<Stream<List<TrackEntity>>> streamAll() {
    try {
      return ResultSuccess(_objectboxProvider.streamAll<TrackModel>());
    } catch (e) {
      return ResultFailure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
