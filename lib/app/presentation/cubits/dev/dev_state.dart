part of 'dev_cubit.dart';

@immutable
sealed class DevState {
  const DevState();
}

final class DevEnabled extends DevState {
  final bool debugInvertedOversizedImages;
  final bool debugRepaintRainbowEnabled;
  final bool debugShowCheckedModeBanner;
  final bool showPerformanceOverlay;

  const DevEnabled({
    this.debugInvertedOversizedImages = false,
    this.debugRepaintRainbowEnabled = false,
    this.debugShowCheckedModeBanner = true,
    this.showPerformanceOverlay = false,
  });

  DevEnabled copyWith({
    bool? debugInvertedOversizedImages,
    bool? debugRepaintRainbowEnabled,
    bool? debugShowCheckedModeBanner,
    bool? showPerformanceOverlay,
  }) {
    return DevEnabled(
      debugInvertedOversizedImages:
          debugInvertedOversizedImages ?? this.debugInvertedOversizedImages,
      debugRepaintRainbowEnabled:
          debugRepaintRainbowEnabled ?? this.debugRepaintRainbowEnabled,
      debugShowCheckedModeBanner:
          debugShowCheckedModeBanner ?? this.debugShowCheckedModeBanner,
      showPerformanceOverlay:
          showPerformanceOverlay ?? this.showPerformanceOverlay,
    );
  }
}
