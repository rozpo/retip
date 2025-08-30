part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {
  const OnboardingEvent();

  @override
  String toString() {
    return runtimeType.toString();
  }
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
