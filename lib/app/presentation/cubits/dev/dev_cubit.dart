import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dev_state.dart';

class DevCubit extends Cubit<DevState> {
  DevCubit() : super(DevEnabled());

  void update({
    bool? debugInvertedOversizedImages,
    bool? debugRepaintRainbowEnabled,
    bool? debugShowCheckedModeBanner,
    bool? showPerformanceOverlay,
  }) {
    if (state is! DevEnabled) return;
    final currentState = state as DevEnabled;

    emit(
      currentState.copyWith(
        debugInvertedOversizedImages: debugInvertedOversizedImages,
        debugRepaintRainbowEnabled: debugRepaintRainbowEnabled,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        showPerformanceOverlay: showPerformanceOverlay,
      ),
    );
  }
}
