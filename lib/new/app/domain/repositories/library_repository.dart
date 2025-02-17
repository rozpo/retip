import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../objectbox.g.dart';
import '../entities/album.dart';
import '../entities/artist.dart';
import '../entities/track.dart';

class LibraryRepository {
  Future<void> scan() async {
    final onAudioQuery = OnAudioQuery();
    final objectbox = GetIt.I.get<Store>();

    final tracks = await onAudioQuery.querySongs();
    final albums = await onAudioQuery.queryAlbums();
    final artists = await onAudioQuery.queryArtists();

    final tracksBox = objectbox.box<Track>();
    for (final track in tracks) {
      if (track.uri == null) continue;

      final entity = await tracksBox
          .query(Track_.location.equals(track.uri!))
          .build()
          .findFirstAsync();

      if (entity == null) {
        final entity = Track(
          artist: track.artist ?? 'Unknown',
          album: track.album ?? 'Unknown',
          title: track.title,
          location: track.uri!,
        );

        tracksBox.putAsync(entity);
      }
    }

    final albumsBox = objectbox.box<Album>();
    for (final album in albums) {
      final entity = await albumsBox
          .query(Album_.title.equals(album.album))
          .build()
          .findFirstAsync();

      if (entity == null) {
        final entity = Album(
          artist: album.artist ?? 'Unknown',
          title: album.album,
        );

        albumsBox.putAsync(entity);
      }
    }

    final artistsBox = objectbox.box<Artist>();
    for (final artist in artists) {
      final entity = await artistsBox
          .query(Artist_.name.equals(artist.artist))
          .build()
          .findFirstAsync();

      if (entity == null) {
        final entity = Artist(
          name: artist.artist,
        );

        artistsBox.putAsync(entity);
      }
    }
  }
}
