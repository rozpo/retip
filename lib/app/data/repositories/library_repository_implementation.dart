import 'dart:typed_data';

import 'package:retip/app/data/models/album_model.dart';
import 'package:retip/app/data/models/artist_model.dart';
import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/data/providers/file_provider.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/data/providers/shared_preferences_provider.dart';
import 'package:retip/app/domain/entities/album_entity.dart';
import 'package:retip/app/domain/entities/artist_entity.dart';
import 'package:retip/app/domain/entities/track_entity.dart';
import 'package:retip/app/domain/repositories/library_repository.dart';

class LibraryRepositoryImplementation implements LibraryRepository {
  final OnAudioQueryProvider onAudioQueryProvider;
  final SharedPreferencesProvider sharedPreferencesProvider;
  final FileProvider _fileProvider;

  LibraryRepositoryImplementation({
    required this.onAudioQueryProvider,
    required this.sharedPreferencesProvider,
    FileProvider? fileProvider,
  }) : _fileProvider = fileProvider ?? FileProvider();

  @override
  Future<List<AlbumEntity>> getAllAlbums() async {
    final result = <AlbumEntity>[];

    final albums = await onAudioQueryProvider.getAllAlbums();
    final tracks = await onAudioQueryProvider.getAllSongs();

    for (final album in albums) {
      Uint8List? albumArtwork =
          await _fileProvider.readFile('album_${album.id}');

      if (albumArtwork == null) {
        albumArtwork = await onAudioQueryProvider.getAlbumArtwork(album.id);

        if (albumArtwork != null) {
          _fileProvider.writeFile(albumArtwork, 'album_${album.id}');
        }
      }

      final albumTracks = tracks
          .where((e) => e.album == album.album)
          .map((e) => TrackModel.fromSongModel(e, albumArtwork))
          .toList();

      if (result.map((e) => e.title).contains(album.album)) {
        final duplicatedAlbum = result.firstWhere(
          (e) => e.title == album.album,
        );

        if (duplicatedAlbum.tracks.length == albumTracks.length) {
          // Duplciated album skipping
          continue;
        }
      }

      result.add(AlbumModel.fromAlbumModel(
        album,
        albumArtwork,
        albumTracks,
      ));
    }

    return result;
  }

  @override
  Future<List<ArtistEntity>> getAllArtists() async {
    final result = <ArtistEntity>[];

    // Fetch all raw data
    final artists = await onAudioQueryProvider.getAllArtists();
    final albums = await onAudioQueryProvider.getAllAlbums();
    final tracks = await onAudioQueryProvider.getAllSongs();

    for (final artist in artists) {
      final artistAlbums =
          albums.where((album) => album.artist == artist.artist);
      Uint8List? artistArtwork =
          await _fileProvider.readFile('artist_${artist.id}');

      if (artistArtwork == null) {
        artistArtwork = await onAudioQueryProvider.getArtistArtwork(artist.id);

        if (artistArtwork != null) {
          _fileProvider.writeFile(artistArtwork, 'artist_${artist.id}');
        }
      }

      final albumsToAdd = <AlbumModel>[];

      for (final artistAlbum in artistAlbums) {
        final albumTracks =
            tracks.where((track) => track.album == artistAlbum.album);
        Uint8List? albumArtwork =
            await _fileProvider.readFile('album_${artistAlbum.id}');

        if (albumArtwork == null) {
          albumArtwork =
              await onAudioQueryProvider.getAlbumArtwork(artistAlbum.id);

          if (albumArtwork != null) {
            _fileProvider.writeFile(albumArtwork, 'album_${artistAlbum.id}');
          }
        }

        final tracksToAdd = <TrackModel>[];

        for (final albumTrack in albumTracks) {
          tracksToAdd.add(TrackModel.fromSongModel(albumTrack, albumArtwork));
        }

        if (albumsToAdd.map((e) => e.title).contains(artistAlbum.album)) {
          final duplicatedAlbum = albumsToAdd.firstWhere(
            (e) => e.title == artistAlbum.album,
          );

          if (duplicatedAlbum.tracks.length == tracksToAdd.length) {
            // Duplciated album skipping
            continue;
          }
        }

        albumsToAdd.add(AlbumModel.fromAlbumModel(
          artistAlbum,
          albumArtwork,
          tracksToAdd,
        ));
      }

      result.add(ArtistModel.fromArtistModel(
        artist,
        artistArtwork,
        albumsToAdd,
      ));
    }

    return result;
  }

  @override
  Future<List<TrackEntity>> getAllTracks() async {
    final data = await onAudioQueryProvider.getAllSongs();

    final artworks = <int, Uint8List>{};
    final tracks = <TrackModel>[];

    for (final track in data) {
      final albumId = track.albumId;
      Uint8List? artwork;

      if (albumId != null) {
        if (artworks.containsKey(albumId)) {
          artwork = artworks[albumId];
        } else {
          artwork = await _fileProvider.readFile('album_$albumId');

          if (artwork != null) {
            artworks.addAll({albumId: artwork});
          }
        }
      }

      tracks.add(TrackModel.fromSongModel(track, artwork));
    }

    return tracks;
  }

  @override
  Future<AlbumEntity> getAlbum(int id) async {
    final albums = await getAllAlbums();

    return albums.firstWhere((album) => album.id == id);
  }

  @override
  Future<ArtistEntity> getArtist(int id) async {
    final artists = await getAllArtists();
    return artists.firstWhere((artist) => artist.id == id);
  }

  @override
  Future<TrackEntity> getTrack(int id) {
    // TODO: implement getTrack
    throw UnimplementedError();
  }
}
