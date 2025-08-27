import 'package:retip/app/domain/errors/result.dart';

abstract interface class OnboardingRepository {
  Future<Result<bool>> onboardingStatus();

  Future<Result<bool>> completeOnboarding();
}
