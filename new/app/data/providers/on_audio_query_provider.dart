import 'package:on_audio_query/on_audio_query.dart';

class OnAudioQueryProvider {
  final OnAudioQuery _onAudioQuery;

  const OnAudioQueryProvider._(
    OnAudioQuery onAudioQuery,
  ) : _onAudioQuery = onAudioQuery;

  static Future<OnAudioQueryProvider> init() async {
    final onAudioQuery = OnAudioQuery();
    return OnAudioQueryProvider._(onAudioQuery);
  }

  Future<bool> permissionRequest() async {
    return await _onAudioQuery.permissionsRequest();
  }

  Future<bool> permissionStatus() async {
    return await _onAudioQuery.permissionsStatus();
  }

  Future<List<SongModel>> querySongs() async {
    return await _onAudioQuery.querySongs();
  }

  Future<List<AlbumModel>> queryAlbums() async {
    return await _onAudioQuery.queryAlbums();
  }

  Future<List<ArtistModel>> queryArtists() async {
    return await _onAudioQuery.queryArtists();
  }

  Future<List<GenreModel>> queryGenres() async {
    return await _onAudioQuery.queryGenres();
  }
}
