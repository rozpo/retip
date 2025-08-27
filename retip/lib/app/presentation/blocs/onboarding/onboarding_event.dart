part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {
  const OnboardingEvent();
}

final class OnboardingCheckStatusEvent extends OnboardingEvent {
  const OnboardingCheckStatusEvent();
}

final class OnboardingCompleteEvent extends OnboardingEvent {
  const OnboardingCompleteEvent();
}

final class OnboardingResetEvent extends OnboardingEvent {
  const OnboardingResetEvent();
}
