import 'package:retip/app/data/models/album_model.dart';
import 'package:retip/app/data/models/artist_model.dart';
import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/repositories/artist_repository.dart';

class OnAudioQueryArtistRepository implements ArtistRepository {
  final _onAudioQueryProvider = OnAudioQueryProvider();

  @override
  Future<List<ArtistEntity>> getAll() async {
    final result = <ArtistModel>[];

    // Fetch all raw data
    final artists = await _onAudioQueryProvider.getAllArtists();
    final albums = await _onAudioQueryProvider.getAllAlbums();
    final tracks = await _onAudioQueryProvider.getAllTracks();

    for (final artist in artists) {
      final artistAlbums =
          albums.where((album) => album.artist == artist.artist);
      final artistArtwork =
          await _onAudioQueryProvider.getArtistArtwork(artist.id);
      final albumsToAdd = <AlbumModel>[];

      for (final artistAlbum in artistAlbums) {
        final albumTracks =
            tracks.where((track) => track.album == artistAlbum.album);
        final albumArtwork =
            await _onAudioQueryProvider.getAlbumArtwork(artistAlbum.id);
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
}
