import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repositories/config_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final ConfigRepository _configRepository;

  OnboardingCubit({
    required ConfigRepository configRepository,
  })  : _configRepository = configRepository,
        super(OnboardingInitial()) {
    checkOnboardingStatus();
  }

  Future<void> checkOnboardingStatus() async {
    final status = _configRepository.getOnboardingStatus();

    if (status) {
      emit(OnboardingInProgress());
    } else {
      emit(OnboardingFinished());
    }
  }

  Future<void> finishOnboarding() async {
    await _configRepository.setOnboardingStatus(false);
    emit(OnboardingFinished());
  }
}
