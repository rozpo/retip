import '../../domain/repositories/config_repository.dart';
import '../providers/shared_preferences_provider.dart';

class ConfigRepositoryI implements ConfigRepository {
  final SharedPreferencesProvider _sharedPreferencesProvider;

  ConfigRepositoryI(SharedPreferencesProvider sharedPreferencesProvider)
      : _sharedPreferencesProvider = sharedPreferencesProvider;

  static const _onboardingKey = 'config_onboarding';

  @override
  bool getOnboardingValue() {
    return _sharedPreferencesProvider.getBool(_onboardingKey, true);
  }

  @override
  Future<void> setOnboardingValue(bool value) async {
    return await _sharedPreferencesProvider.setBool(_onboardingKey, value);
  }
}
