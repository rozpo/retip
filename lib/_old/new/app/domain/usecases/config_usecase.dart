import '../repositories/config_repository.dart';

class ConfigUsecase {
  final ConfigRepository _configRepository;

  ConfigUsecase({
    required ConfigRepository configRepository,
  }) : _configRepository = configRepository;

  bool showOnboarding() {
    return _configRepository.showOnboarding();
  }

  void disableOnboarding() {
    _configRepository.disableOnboarding();
  }
}
