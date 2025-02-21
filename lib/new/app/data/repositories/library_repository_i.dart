import '../../../../objectbox.g.dart';
import '../../domain/entities/track_entity.dart';
import '../../domain/repositories/library_repository.dart';
import '../models/track_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

class LibraryRepositoryI implements LibraryRepository {
  final ObjectboxProvider _objectboxProvider;
  final OnAudioQueryProvider _onAudioQueryProvider;

  const LibraryRepositoryI({
    required ObjectboxProvider objectboxProvider,
    required OnAudioQueryProvider onAudioQueryProvider,
  })  : _objectboxProvider = objectboxProvider,
        _onAudioQueryProvider = onAudioQueryProvider;

  @override
  Future<void> scan() async {
    final tracks = await _onAudioQueryProvider.getAllTracks();

    for (final track in tracks) {
      if (track.uri == null) continue;

      final condition = TrackModel_.location.equals(track.uri!);
      TrackModel? entity =
          await _objectboxProvider.findFirst<TrackModel>(condition);

      if (entity != null) continue;

      entity = TrackModel(
        title: track.title,
        location: track.uri!,
      );

      _objectboxProvider.insert<TrackModel>(entity);
    }
  }

  @override
  Stream<List<TrackEntity>> tracksStream() {
    return _objectboxProvider.stream<TrackModel>();
  }
}
