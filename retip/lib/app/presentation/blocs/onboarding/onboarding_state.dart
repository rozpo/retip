part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {
  const OnboardingState();
}

final class OnboardingInitState extends OnboardingState {
  const OnboardingInitState();
}

final class OnboardingInProgressState extends OnboardingState {
  const OnboardingInProgressState();
}

final class OnboardingCompletedState extends OnboardingState {
  const OnboardingCompletedState();
}
