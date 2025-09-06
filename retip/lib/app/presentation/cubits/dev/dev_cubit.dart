import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'dev_state.dart';

class DevCubit extends HydratedCubit<DevState> {
  DevCubit() : super(DevState());

  void enable() => emit(state.copyWith(isEnabled: true));

  void disable() => emit(state.copyWith(isEnabled: false));

  void set({
    bool? showPerformanceOverlay,
    bool? repaintRainbowEnabled,
    bool? invertOversizedImages,
  }) {
    if (!state.isEnabled) return;

    emit(
      state.copyWith(
        showPerformanceOverlay: showPerformanceOverlay,
        invertOversizedImages: invertOversizedImages,
        repaintRainbowEnabled: repaintRainbowEnabled,
      ),
    );
  }

  @override
  DevState? fromJson(Map<String, dynamic> json) {
    return DevState(
      isEnabled: json['isEnabled'] ?? !kReleaseMode,
      showPerformanceOverlay: json['showPerformanceOverlay'] ?? false,
      invertOversizedImages: json['invertOversizedImages'] ?? false,
      repaintRainbowEnabled: json['repaintRainbowEnabled'] ?? false,
    );
  }

  @override
  Map<String, dynamic>? toJson(DevState state) {
    return {
      'isEnabled': state.isEnabled,
      'showPerformanceOverlay': state.showPerformanceOverlay,
      'invertOversizedImages': state.invertOversizedImages,
      'repaintRainbowEnabled': state.repaintRainbowEnabled,
    };
  }
}
