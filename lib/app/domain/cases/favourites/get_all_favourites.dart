import 'package:get_it/get_it.dart';
import 'package:retip/app/domain/cases/get_all_albums.dart';
import 'package:retip/app/domain/cases/get_all_artists.dart';
import 'package:retip/app/domain/cases/get_all_tracks.dart';
import 'package:retip/app/domain/cases/playlist/get_all_playlists.dart';
import 'package:retip/app/domain/entities/abstract_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin GetAllFavourites {
  static Future<List<T>> call<T extends AbstractEntity>(String key) async {
    final prefs = GetIt.I.get<SharedPreferences>();

    final favourites = prefs.getStringList(key) ?? [];

    if (key == 'ArtistModel') {
      final artists = await GetAllArtists.call();

      return artists.where((artist) {
        return favourites.contains(artist.id.toString());
      }).toList() as List<T>;
    }

    if (key == 'AlbumModel') {
      final albums = await GetAllAlbums.call();

      return albums.where((album) {
        return favourites.contains(album.id.toString());
      }).toList() as List<T>;
    }

    if (key == 'TrackModel') {
      final tracks = await GetAllTracks.call();

      return tracks.where((track) {
        return favourites.contains(track.id.toString());
      }).toList() as List<T>;
    }

    final playlists = await GetAllPlaylists.call();

    return playlists.where((playlist) {
      return favourites.contains(playlist.id.toString());
    }).toList() as List<T>;
  }
}
