import '../../domain/repositories/library_repository.dart';
import '../models/track_model.dart';
import '../providers/objectbox_provider.dart';
import '../providers/on_audio_query_provider.dart';

class LibraryRepositoryI implements LibraryRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;
  final ObjectboxProvider _objectboxProvider;

  LibraryRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
    required ObjectboxProvider objectboxProvider,
  })  : _onAudioQueryProvider = onAudioQueryProvider,
        _objectboxProvider = objectboxProvider;

  @override
  Future<int> scan() async {
    final permissionStatus = await _onAudioQueryProvider.permissionStatus();

    if (permissionStatus == false) {
      final permissionRequest = await _onAudioQueryProvider.permissionRequest();

      if (permissionRequest == false) {
        // Create custom exception
        throw Exception('Permission denied');
      }
    }

    final songs = await _onAudioQueryProvider.querySongs();
    final tracks = await _objectboxProvider.getAll<TrackModel>();

    final newSongs = songs.where((song) {
      return tracks.every((track) => track.location != song.uri);
    }).toList();

    final newTracks = newSongs.map((song) {
      return TrackModel.fromOnAudioQuery(song);
    }).toList();

    final ids = await _objectboxProvider.insertMany(newTracks);
    return ids.length;
  }
}
