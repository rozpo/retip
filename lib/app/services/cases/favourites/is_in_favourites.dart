import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/abstract_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin IsInFavourites {
  static bool call(AbstractEntity entity) {
    final prefs = GetIt.I.get<SharedPreferences>();

    final key = entity.runtimeType.toString();
    final favourities = prefs.getStringList(key) ?? [];

    return favourities.contains(entity.id.toString());
  }
}
