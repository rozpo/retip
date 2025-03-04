import '../repositories/config_repository.dart';

class IntroFacade {
  final ConfigRepository _configRepository;

  IntroFacade(ConfigRepository configRepository)
      : _configRepository = configRepository;

  bool isEnabled() {
    return _configRepository.getOnboardingValue();
  }

  Future<void> disable() async {
    await _configRepository.setOnboardingValue(false);
  }
}
