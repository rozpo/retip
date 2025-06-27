import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dev_state.dart';

class DevCubit extends Cubit<DevState> {
  DevCubit({bool isEnabled = false})
    : super(isEnabled ? DevEnabled() : DevDisabled());

  void stepToDevMode() {
    if (state is! DevDisabled) return;

    final disabledState = state as DevDisabled;
    final stepsToBeDev = disabledState.stepsToBeDev + 1;

    if (stepsToBeDev < 10) {
      emit(DevDisabled(stepsToBeDev));
    } else {
      emit(DevEnabled());
    }
  }

  void disableDevMode() {
    emit(DevDisabled());
  }

  void setFlag({
    bool? debugRepaintTextRainbowEnabled,
    bool? debugPaintLayerBordersEnabled,
    bool? debugInvertedOversizedImages,
    bool? debugPaintBaselinesEnabled,
    bool? debugRepaintRainbowEnabled,
    bool? debugShowCheckedModeBanner,
    bool? debugPaintPointersEnabled,
    bool? showPerformanceOverlay,
    bool? debugPaintSizeEnabled,
  }) {
    if (state is! DevEnabled) return;
    final currentState = state as DevEnabled;

    emit(
      currentState.copyWith(
        debugRepaintTextRainbowEnabled: debugRepaintTextRainbowEnabled,
        debugPaintLayerBordersEnabled: debugPaintLayerBordersEnabled,
        debugInvertedOversizedImages: debugInvertedOversizedImages,
        debugPaintBaselinesEnabled: debugPaintBaselinesEnabled,
        debugRepaintRainbowEnabled: debugRepaintRainbowEnabled,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        debugPaintPointersEnabled: debugPaintPointersEnabled,
        showPerformanceOverlay: showPerformanceOverlay,
        debugPaintSizeEnabled: debugPaintSizeEnabled,
      ),
    );
  }
}
