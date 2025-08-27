import 'package:retip/app/domain/errors/result.dart';

/// Repository to manage onboarding status.
abstract interface class OnboardingRepository {
  /// Returns `true` if onboarding has been completed, `false` otherwise.
  Result<bool> onboardingStatus();

  /// Marks onboarding as completed.
  Future<Result<bool>> completeOnboarding();

  /// Resets the onboarding status to not completed.
  Future<Result<bool>> resetOnboarding();
}
