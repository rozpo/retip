abstract class ConfigRepository {
  bool getOnboardingStatus();

  Future<void> setOnboardingStatus(bool value);
}
