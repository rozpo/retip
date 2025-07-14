import '../../domain/enums/config_enum.dart';
import '../providers/shared_preferences_provider.dart';

interface class ConfigRepository {
  final SharedPreferencesProvider _sharedPreferencesProvider;

  const ConfigRepository({
    required SharedPreferencesProvider sharedPreferencesProvider,
  }) : _sharedPreferencesProvider = sharedPreferencesProvider;

  bool getValue(ConfigEnum key) {
    return _sharedPreferencesProvider.getBool(key.key);
  }

  Future<void> setValue(ConfigEnum key, bool value) async {
    return await _sharedPreferencesProvider.setBool(key.key, value);
  }
}
