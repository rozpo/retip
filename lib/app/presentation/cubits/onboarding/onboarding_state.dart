part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingInProgress extends OnboardingState {}

class OnboardingFinished extends OnboardingState {}
