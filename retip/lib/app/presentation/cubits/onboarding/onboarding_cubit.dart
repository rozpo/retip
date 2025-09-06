import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends HydratedCubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState());

  void finish() => emit(OnboardingState(true));

  void reset() => emit(OnboardingState(false));

  @override
  OnboardingState? fromJson(Map<String, dynamic> json) {
    return OnboardingState(json['isDone']);
  }

  @override
  Map<String, dynamic>? toJson(OnboardingState state) {
    return {'isDone': state.isDone};
  }
}
