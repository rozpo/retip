import 'package:get_it/get_it.dart';
import 'package:retip/app/domain/entities/abstract_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin RemoveFromFavourites {
  static Future<bool> call(AbstractEntity entity) async {
    final prefs = GetIt.I.get<SharedPreferences>();

    final key = entity.runtimeType.toString();
    final favourites = prefs.getStringList(key) ?? [];

    favourites.remove(entity.id.toString());

    return await prefs.setStringList(key, favourites);
  }
}
