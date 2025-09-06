part of 'dev_cubit.dart';

@immutable
final class DevState {
  final bool isEnabled;

  final bool showPerformanceOverlay;
  final bool invertOversizedImages;
  final bool repaintRainbowEnabled;

  const DevState({
    this.showPerformanceOverlay = false,
    this.invertOversizedImages = false,
    this.repaintRainbowEnabled = false,
    this.isEnabled = !kReleaseMode,
  });

  DevState copyWith({
    bool? showPerformanceOverlay,
    bool? invertOversizedImages,
    bool? repaintRainbowEnabled,
    bool? isEnabled,
  }) {
    return DevState(
      isEnabled: isEnabled ?? this.isEnabled,
      showPerformanceOverlay:
          showPerformanceOverlay ?? this.showPerformanceOverlay,
      invertOversizedImages:
          invertOversizedImages ?? this.invertOversizedImages,
      repaintRainbowEnabled:
          repaintRainbowEnabled ?? this.repaintRainbowEnabled,
    );
  }

  @override
  String toString() {
    return 'isEnabled = $isEnabled\n'
        'showPerformanceOverlay = $showPerformanceOverlay\n'
        'invertOversizedImages = $invertOversizedImages\n'
        'repaintRainbowEnabled = $repaintRainbowEnabled';
  }
}
