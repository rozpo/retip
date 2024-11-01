import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin RemoveFromFavourites {
  static Future<bool> call(TrackEntity track) async {
    final prefs = GetIt.I.get<SharedPreferences>();
    final favouriteTracks = prefs.getStringList('favourite_tracks') ?? [];

    favouriteTracks.remove(track.id.toString());

    return await prefs.setStringList('favourite_tracks', favouriteTracks);
  }
}
