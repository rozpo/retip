import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';

/// Provider to interact with the OnAudioQuery package.
class OnAudioQueryProvider {
  /// Instance of the OnAudioQuery package.
  final OnAudioQuery _onAudioQuery;

  const OnAudioQueryProvider._(this._onAudioQuery);

  static Future<OnAudioQueryProvider> init() async {
    return OnAudioQueryProvider._(OnAudioQuery());
  }

  // === PRIVATE =================================================================

  /// Get songs from a specific id and type.
  ///
  /// [id] is the id of the audio.
  /// [type] is the type of the audio.
  /// [AudiosFromType] is the type of the audio.
  Future<List<SongModel>> _getSongs(int id, AudiosFromType type) async {
    // Check if the type is a id not a name.
    assert(
      type == AudiosFromType.ALBUM_ID ||
          type == AudiosFromType.ARTIST_ID ||
          type == AudiosFromType.GENRE_ID,
    );

    // Query the songs from the specific id.
    return await _onAudioQuery.queryAudiosFrom(
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: SongSortType.TITLE,
      type,
      id,
    );
  }

  /// Get artwork from a specific id and type.
  ///
  /// [id] is the id of the audio.
  /// [type] is the type of the audio.
  /// [ArtworkType] is the type of the artwork.
  Future<Uint8List?> _getArtwork(int id, ArtworkType type) async {
    return await _onAudioQuery.queryArtwork(
      format: ArtworkFormat.JPEG,
      quality: 100,
      size: 500,
      id,
      type,
    );
  }

  /// Get a specific media from a specific id.
  ///
  /// [T] is the type of the media target.
  /// [type] is the type of the media source.
  /// [key] is the field to compare.
  /// [id] is value for search.
  Future<List> _getQuery({
    required WithFiltersType type,
    required String query,
    required dynamic args,
  }) async {
    final data = await _onAudioQuery.queryWithFilters(query, type, args: args);
    return data;
  }

  // === PERMISSIONS =============================================================

  /// Check the media storage permissions status.
  Future<bool> permissionsStatus() async {
    return await _onAudioQuery.permissionsStatus();
  }

  /// Request the media storage permissions.
  Future<bool> permissionsRequest() async {
    return await _onAudioQuery.permissionsRequest();
  }

  // === SONGS ===================================================================

  /// Get all songs from the device.
  Future<List<SongModel>> getAllSongs() async {
    return await _onAudioQuery.querySongs();
  }

  /// Get songs from a specific genre.
  Future<List<SongModel>> getGenreSongs(int id) async {
    return await _getSongs(id, AudiosFromType.GENRE_ID);
  }

  /// Get songs from a specific artist.
  Future<List<SongModel>> getArtistSongs(int id) async {
    return await _getSongs(id, AudiosFromType.ARTIST_ID);
  }

  /// Get songs from a specific album.
  Future<List<SongModel>> getAlbumSongs(int id) async {
    return await _getSongs(id, AudiosFromType.ALBUM_ID);
  }

  /// Get artist from a specific id.
  Future<SongModel?> getSong(int id) async {
    final songs = await _onAudioQuery.querySongs();
    return songs.firstWhere((element) => element.id == id);
  }

  // === ALBUMS ==================================================================

  /// Get all albums from the device.
  Future<List<AlbumModel>> getAllAlbums() async {
    return await _onAudioQuery.queryAlbums();
  }

  /// Get albums from a specific artist.
  Future<List<AlbumModel>> getArtistAlbums(int id) async {
    final artist = await getArtist(id);

    if (artist == null) {
      throw Exception('Artist not found');
    }

    final data = await _getQuery(
      type: WithFiltersType.ALBUMS,
      args: AlbumsArgs.ARTIST,
      query: artist.artist,
    );

    final albums = data.map((e) => AlbumModel(e));

    return albums.where((element) => element.artistId == artist.id).toList();
  }

  /// Get artist from a specific id.
  Future<AlbumModel?> getAlbum(int id) async {
    final albums = await getAllAlbums();
    return albums.firstWhere((element) => element.id == id);
  }

  // === ARTISTS =================================================================

  /// Get all artists from the device.
  Future<List<ArtistModel>> getAllArtists() async {
    return await _onAudioQuery.queryArtists();
  }

  /// Get artist from a specific id.
  Future<ArtistModel?> getArtist(int id) async {
    final artists = await getAllArtists();
    return artists.firstWhere((element) => element.id == id);
  }

  // === GENRES ==================================================================

  /// Get all artists from the device.
  Future<List<GenreModel>> getAllGenres() async {
    return await _onAudioQuery.queryGenres();
  }

  /// Get artist from a specific id.
  Future<GenreModel?> getGenre(int id) async {
    final genres = await getAllGenres();
    return genres.firstWhere((element) => element.id == id);
  }

  // === ARTWORKS ================================================================

  /// Get artwork from a specific song.
  Future<Uint8List?> getSongArtwork(int id) async {
    return await _getArtwork(id, ArtworkType.AUDIO);
  }

  /// Get artwork from a specific album.
  Future<Uint8List?> getAlbumArtwork(int id) async {
    return await _getArtwork(id, ArtworkType.ALBUM);
  }

  /// Get artwork from a specific artist.
  Future<Uint8List?> getArtistArtwork(int id) async {
    return await _getArtwork(id, ArtworkType.ARTIST);
  }

  /// Get artwork from a specific genre.
  Future<Uint8List?> getGenreArtwork(int id) async {
    return await _getArtwork(id, ArtworkType.GENRE);
  }
}
