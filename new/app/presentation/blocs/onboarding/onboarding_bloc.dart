import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/services/onboarding_service.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingService _onboardingService;

  OnboardingBloc({required OnboardingService onboardingService})
      : _onboardingService = onboardingService,
        super(onboardingService.getOnboardingStatus()
            ? const OnboardingFinishedState()
            : const OnboardingInProgressState()) {
    on<OnboadringFinishEvent>(_onFinish);
  }

  void _onFinish(OnboadringFinishEvent event, Emitter<OnboardingState> emit) {
    _onboardingService.finishOnboarding();
    emit(const OnboardingFinishedState());
  }
}
