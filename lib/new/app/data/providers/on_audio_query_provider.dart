import 'package:on_audio_query/on_audio_query.dart';

class OnAudioQueryProvider {
  final OnAudioQuery _onAudioQuery;

  const OnAudioQueryProvider({
    required OnAudioQuery onAudioQuery,
  }) : _onAudioQuery = onAudioQuery;

  Future<List<SongModel>> getAllTracks() async {
    return await _onAudioQuery.querySongs();
  }

  Future<List<AlbumModel>> getAllAlbums() async {
    return await _onAudioQuery.queryAlbums();
  }

  Future<List<ArtistModel>> getAllArtists() async {
    return await _onAudioQuery.queryArtists();
  }

  Future<List<GenreModel>> getAllGenres() async {
    return await _onAudioQuery.queryGenres();
  }
}
