import '../repositories/config_repository.dart';

class IntroFacade {
  final ConfigRepository _configRepository;

  IntroFacade(ConfigRepository configRepository)
      : _configRepository = configRepository;

  bool isIntroPageEnabled() {
    return _configRepository.getOnboardingValue();
  }

  Future<void> disableIntroPage() async {
    await _configRepository.setOnboardingValue(false);
  }
}
