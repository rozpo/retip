import 'dart:typed_data';

import 'package:retip/app/data/models/album_model.dart';
import 'package:retip/app/data/models/artist_model.dart';
import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/services/repositories/library_repository.dart';

class LibraryRepositoryImplementation implements LibraryRepository {
  final OnAudioQueryProvider onAudioQueryProvider;

  LibraryRepositoryImplementation({required this.onAudioQueryProvider});

  @override
  Future<List<AlbumEntity>> getAllAlbums() async {
    final result = <AlbumEntity>[];

    final albums = await onAudioQueryProvider.getAllAlbums();
    final tracks = await onAudioQueryProvider.getAllTracks();

    for (final album in albums) {
      final albumArtwork = await onAudioQueryProvider.getAlbumArtwork(album.id);
      final albumTracks = tracks
          .where((e) => e.album == album.album)
          .map((e) => TrackModel.fromSongModel(e, albumArtwork))
          .toList();

      result.add(AlbumModel.fromAlbumModel(album, albumArtwork, albumTracks));
    }

    return result;
  }

  @override
  Future<List<ArtistEntity>> getAllArtists() async {
    final result = <ArtistEntity>[];

    // Fetch all raw data
    final artists = await onAudioQueryProvider.getAllArtists();
    final albums = await onAudioQueryProvider.getAllAlbums();
    final tracks = await onAudioQueryProvider.getAllTracks();

    for (final artist in artists) {
      final artistAlbums =
          albums.where((album) => album.artist == artist.artist);
      final artistArtwork =
          await onAudioQueryProvider.getArtistArtwork(artist.id);
      final albumsToAdd = <AlbumModel>[];

      for (final artistAlbum in artistAlbums) {
        final albumTracks =
            tracks.where((track) => track.album == artistAlbum.album);
        final albumArtwork =
            await onAudioQueryProvider.getAlbumArtwork(artistAlbum.id);
        final tracksToAdd = <TrackModel>[];

        for (final albumTrack in albumTracks) {
          tracksToAdd.add(TrackModel.fromSongModel(albumTrack, albumArtwork));
        }

        albumsToAdd.add(
            AlbumModel.fromAlbumModel(artistAlbum, albumArtwork, tracksToAdd));
      }

      result
          .add(ArtistModel.fromArtistModel(artist, artistArtwork, albumsToAdd));
    }

    return result;
  }

  @override
  Future<List<TrackEntity>> getAllTracks() async {
    final data = await onAudioQueryProvider.getAllTracks();

    final artworks = <int, Uint8List>{};
    final tracks = <TrackModel>[];

    for (final track in data) {
      final albumId = track.albumId;
      Uint8List? artwork;

      if (albumId != null) {
        if (artworks.containsKey(albumId)) {
          artwork = artworks[albumId];
        } else {
          artwork = await onAudioQueryProvider.getAudioArtwork(track.id);

          if (artwork != null) {
            artworks.addAll({albumId: artwork});
          }
        }
      }

      tracks.add(TrackModel.fromSongModel(track, artwork));
    }

    return tracks;
  }
}
