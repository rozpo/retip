import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/domain/repositories/onboarding_repository.dart';

import '../../../domain/errors/result.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository _onboardingRepository;

  OnboardingBloc({required OnboardingRepository onboardingRepository})
    : _onboardingRepository = onboardingRepository,
      super(const OnboardingInitState()) {
    on<OnboardingCheckStatusEvent>(_checkStatus);
    on<OnboardingCompleteEvent>(_complete);
    on<OnboardingResetEvent>(_reset);

    add(const OnboardingCheckStatusEvent());
  }

  void _checkStatus(
    OnboardingCheckStatusEvent event,
    Emitter<OnboardingState> emit,
  ) {
    final status = _onboardingRepository.onboardingStatus();

    if (status is ResultSuccess<bool> && status.data) {
      emit(OnboardingCompletedState());
    } else {
      emit(OnboardingInProgressState());
    }
  }

  void _complete(
    OnboardingCompleteEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await _onboardingRepository.completeOnboarding();

    if (result is ResultSuccess<bool> && result.data) {
      emit(OnboardingCompletedState());
    }
  }

  void _reset(OnboardingResetEvent event, Emitter<OnboardingState> emit) async {
    final result = await _onboardingRepository.resetOnboarding();

    if (result is ResultSuccess<bool> && result.data) {
      emit(OnboardingInProgressState());
    }
  }
}
