import '../../data/repositories/playlist_repository.dart';

interface class PlaylistService {
  final PlaylistRepository _playlistRepository;

  const PlaylistService({
    required PlaylistRepository playlistRepository,
  }) : _playlistRepository = playlistRepository;

  Future<int> create(String name) async {
    return await _playlistRepository.create(name);
  }

  Future<bool> rename(int id, String name) async {
    return await _playlistRepository.rename(id, name);
  }

  Future<bool> delete(int id) async {
    return await _playlistRepository.delete(id);
  }
}
