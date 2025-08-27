import 'package:retip/app/data/providers/shared_preferences_provider.dart';
import 'package:retip/app/domain/errors/result.dart';

import '../../domain/repositories/onboarding_repository.dart';

final class OnboardingRepositoryI implements OnboardingRepository {
  final SharedPreferencesProvider _sharedPreferencesProvider;

  OnboardingRepositoryI({
    required SharedPreferencesProvider sharedPreferencesProvider,
  }) : _sharedPreferencesProvider = sharedPreferencesProvider;

  static const String _onboardingKey = 'onboarding_completed';

  @override
  Future<Result<bool>> completeOnboarding() async {
    try {
      final result = await _sharedPreferencesProvider.setBool(
        _onboardingKey,
        true,
      );
      return ResultSuccess(result);
    } catch (e) {
      return ResultFailure(Exception('Failed to complete onboarding: $e'));
    }
  }

  @override
  Result<bool> onboardingStatus() {
    try {
      final result = _sharedPreferencesProvider.getBool(_onboardingKey);
      return ResultSuccess(result);
    } catch (e) {
      return ResultFailure(Exception('Failed to get onboarding status: $e'));
    }
  }

  @override
  Future<Result<bool>> resetOnboarding() async {
    try {
      final result = await _sharedPreferencesProvider.setBool(
        _onboardingKey,
        false,
      );
      return ResultSuccess(result);
    } catch (e) {
      return ResultFailure(Exception('Failed to reset onboarding status: $e'));
    }
  }
}
