import '../../domain/repositories/library_repository.dart';
import '../models/track_model.dart';
import '../providers/on_audio_query_provider.dart';

class LibraryRepositoryI implements LibraryRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;

  LibraryRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
  }) : _onAudioQueryProvider = onAudioQueryProvider;

  @override
  Future<void> scan() async {
    final permissionStatus = await _onAudioQueryProvider.permissionStatus();

    if (permissionStatus == false) {
      final permissionRequest = await _onAudioQueryProvider.permissionRequest();

      if (permissionRequest == false) {
        // Create custom exception
        throw Exception('Permission denied');
      }
    }

    final songs = await _onAudioQueryProvider.querySongs();

    songs.map((song) {
      return TrackModel.fromOnAudioQuery(song);
    }).toList();
  }
}
