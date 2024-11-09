import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/abstract_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin AddToFavourites {
  static Future<bool> call(AbstractEntity entity) async {
    final prefs = GetIt.I.get<SharedPreferences>();

    final key = entity.runtimeType.toString();
    final favourites = prefs.getStringList(key) ?? [];

    if (favourites.contains(entity.id.toString())) {
      return true;
    }

    favourites.add(entity.id.toString());

    return await prefs.setStringList(key, favourites);
  }
}
