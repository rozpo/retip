import '../../../../objectbox.g.dart';
import '../../domain/entities/track_entity.dart';
import '../../domain/repositories/library_repository.dart';
import '../models/track_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

class LibraryRepositoryI implements LibraryRepository {
  final ObjectboxProvider<TrackModel> _trackObjectboxProvider;
  final OnAudioQueryProvider _onAudioQueryProvider;

  const LibraryRepositoryI({
    required ObjectboxProvider<TrackModel> trackObjectboxProvider,
    required OnAudioQueryProvider onAudioQueryProvider,
  })  : _trackObjectboxProvider = trackObjectboxProvider,
        _onAudioQueryProvider = onAudioQueryProvider;

  @override
  Future<void> scan() async {
    final tracks = await _onAudioQueryProvider.getTracks();

    for (final track in tracks) {
      final condition = TrackModel_.location.equals(track.location);
      final entity = await _trackObjectboxProvider.findFirst(condition);

      if (entity != null) continue;

      _trackObjectboxProvider.insert(track);
    }
  }

  @override
  Stream<List<TrackEntity>> tracksStream() {
    return _trackObjectboxProvider.stream();
  }
}
