import 'package:get_it/get_it.dart';
import 'package:retip/app/services/cases/get_all_albums.dart';
import 'package:retip/app/services/cases/get_all_artists.dart';
import 'package:retip/app/services/cases/get_all_tracks.dart';
import 'package:retip/app/services/entities/abstract_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin GetAllFavourites {
  static Future<List<T>> call<T extends AbstractEntity>(String key) async {
    final prefs = GetIt.I.get<SharedPreferences>();

    // final key = T is ArtistEntity
    //     ? 'ArtistEntity'
    //     : T is AlbumEntity
    //         ? 'AlbumEntity'
    //         : 'TrackEntity';

    final favourities = prefs.getStringList(key) ?? [];

    if (key == 'ArtistModel') {
      final artists = await GetAllArtists.call();

      return artists.where((artist) {
        return favourities.contains(artist.id.toString());
      }).toList() as List<T>;
    }

    if (key == 'AlbumModel') {
      final albums = await GetAllAlbums.call();

      return albums.where((album) {
        return favourities.contains(album.id.toString());
      }).toList() as List<T>;
    }

    final tracks = await GetAllTracks.call();

    return tracks.where((track) {
      return favourities.contains(track.id.toString());
    }).toList() as List<T>;
  }
}
