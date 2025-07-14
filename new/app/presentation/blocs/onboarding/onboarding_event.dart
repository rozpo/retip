part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {
  const OnboardingEvent();
}

final class OnboadringFinishEvent extends OnboardingEvent {
  const OnboadringFinishEvent();
}
