import '../../data/repositories/playlist_repository.dart';

interface class PlaylistService {
  final PlaylistRepository _playlistRepository;

  const PlaylistService({
    required PlaylistRepository playlistRepository,
  }) : _playlistRepository = playlistRepository;

  Future<int> create(String name) async {
    return await _playlistRepository.create(name);
  }
}
