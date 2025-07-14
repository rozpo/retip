import '../../data/repositories/config_repository.dart';
import '../enums/config_enum.dart';

interface class OnboardingService {
  final ConfigRepository _configRepository;

  const OnboardingService({
    required ConfigRepository configRepository,
  }) : _configRepository = configRepository;

  bool getOnboardingStatus() {
    return _configRepository.getValue(ConfigEnum.onboarding);
  }

  Future<void> finishOnboarding() async {
    return await _configRepository.setValue(ConfigEnum.onboarding, true);
  }

  Future<void> resetOnboarding() async {
    return await _configRepository.setValue(ConfigEnum.onboarding, false);
  }
}
