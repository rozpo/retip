import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';

class OnAudioQueryProvider {
  final _onAudioQuery = OnAudioQuery();

  Future<List<SongModel>> getAllTracks() async {
    if (await _onAudioQuery.checkAndRequest() == false) {
      return [];
    }

    return await _onAudioQuery.querySongs();
  }

  Future<Uint8List?> getAudioArtwork(int id) async {
    return await _onAudioQuery.queryArtwork(
      id,
      ArtworkType.AUDIO,
      size: 500,
      format: ArtworkFormat.JPEG,
    );
  }

  Future<List<AlbumModel>> getAllAlbums() async {
    if (await _onAudioQuery.checkAndRequest() == false) {
      return [];
    }

    return await _onAudioQuery.queryAlbums();
  }

  Future<Uint8List?> getAlbumArtwork(int id) async {
    return await _onAudioQuery.queryArtwork(
      id,
      ArtworkType.ALBUM,
      size: 500,
      format: ArtworkFormat.JPEG,
    );
  }

  Future<List<ArtistModel>> getAllArtists() async {
    if (await _onAudioQuery.checkAndRequest() == false) {
      return [];
    }

    return await _onAudioQuery.queryArtists();
  }

  Future<Uint8List?> getArtistArtwork(int id) async {
    return await _onAudioQuery.queryArtwork(
      id,
      ArtworkType.ARTIST,
      size: 500,
      format: ArtworkFormat.JPEG,
    );
  }
}
