import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin IsInFavourites {
  static bool call(TrackEntity track) {
    final prefs = GetIt.I.get<SharedPreferences>();
    final favouriteTracks = prefs.getStringList('favourite_tracks') ?? [];

    return favouriteTracks.contains(track.id.toString());
  }
}
