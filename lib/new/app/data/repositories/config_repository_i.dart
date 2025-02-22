import '../../domain/repositories/config_repository.dart';
import '../providers/shared_preferences_provider.dart';

class ConfigRepositoryI implements ConfigRepository {
  final SharedPreferencesProvider _sharedPreferencesProvider;

  const ConfigRepositoryI({
    required SharedPreferencesProvider sharedPreferencesProvider,
  }) : _sharedPreferencesProvider = sharedPreferencesProvider;

  static const _skipOnboardingKey = 'skip_onboarding';
  @override
  bool showOnboarding() {
    return _sharedPreferencesProvider.getBool(_skipOnboardingKey) == false;
  }

  @override
  void disableOnboarding() {
    _sharedPreferencesProvider.setBool(_skipOnboardingKey, true);
  }
}
