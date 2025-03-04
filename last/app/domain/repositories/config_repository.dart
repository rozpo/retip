/// Interface for the ConfigRepository
abstract class ConfigRepository {
  /// Get the onboarding value
  bool getOnboardingValue();

  // Set the onboarding state
  Future<void> setOnboardingValue(bool value);
}
