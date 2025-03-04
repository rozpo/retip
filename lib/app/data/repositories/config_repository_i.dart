import '../../domain/repositories/config_repository.dart';
import '../providers/shared_preferences_provider.dart';

class ConfigRepositoryI implements ConfigRepository {
  static const _onboardingKey = 'config_onboarding';

  final SharedPreferencesProvider _sharedPreferencesProvider;

  ConfigRepositoryI({
    required SharedPreferencesProvider sharedPreferencesProvider,
  }) : _sharedPreferencesProvider = sharedPreferencesProvider;

  @override
  bool getOnboardingStatus() {
    return _sharedPreferencesProvider.getBool(_onboardingKey, true);
  }

  @override
  Future<void> setOnboardingStatus(bool value) {
    return _sharedPreferencesProvider.setBool(_onboardingKey, value);
  }
}
