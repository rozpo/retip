part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {
  const OnboardingState();
}

final class OnboardingInProgressState extends OnboardingState {
  const OnboardingInProgressState();
}

final class OnboardingFinishedState extends OnboardingState {
  const OnboardingFinishedState();
}
