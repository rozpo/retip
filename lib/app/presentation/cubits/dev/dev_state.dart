part of 'dev_cubit.dart';

@immutable
sealed class DevState {
  const DevState();
}

final class DevDisabled extends DevState {
  final int stepsToBeDev;

  const DevDisabled([this.stepsToBeDev = 0]);

  @override
  String toString() {
    return '$runtimeType: [stepsToBeDev = $stepsToBeDev]';
  }
}

final class DevEnabled extends DevState {
  final bool debugRepaintTextRainbowEnabled;
  final bool debugPaintLayerBordersEnabled;
  final bool debugInvertedOversizedImages;
  final bool debugPaintBaselinesEnabled;
  final bool debugRepaintRainbowEnabled;
  final bool debugShowCheckedModeBanner;
  final bool debugPaintPointersEnabled;
  final bool showPerformanceOverlay;
  final bool debugPaintSizeEnabled;

  @override
  String toString() {
    var msg = '$runtimeType';
    msg +=
        '\n[debugRepaintTextRainbowEnabled = $debugRepaintTextRainbowEnabled ]';
    msg +=
        '\n[debugPaintLayerBordersEnabled = $debugPaintLayerBordersEnabled ]';
    msg += '\n[debugInvertedOversizedImages = $debugInvertedOversizedImages ]';
    msg += '\n[debugPaintBaselinesEnabled = $debugPaintBaselinesEnabled ]';
    msg += '\n[debugRepaintRainbowEnabled = $debugRepaintRainbowEnabled ]';
    msg += '\n[debugShowCheckedModeBanner = $debugShowCheckedModeBanner ]';
    msg += '\n[debugPaintPointersEnabled = $debugPaintPointersEnabled ]';
    msg += '\n[showPerformanceOverlay = $showPerformanceOverlay ]';
    msg += '\n[debugPaintSizeEnabled = $debugPaintSizeEnabled ]';

    return msg;
  }

  const DevEnabled({
    this.debugRepaintTextRainbowEnabled = false,
    this.debugPaintLayerBordersEnabled = false,
    this.debugInvertedOversizedImages = false,
    this.debugPaintBaselinesEnabled = false,
    this.debugRepaintRainbowEnabled = false,
    this.debugShowCheckedModeBanner = true,
    this.debugPaintPointersEnabled = false,
    this.showPerformanceOverlay = false,
    this.debugPaintSizeEnabled = false,
  });

  DevEnabled copyWith({
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
    return DevEnabled(
      debugRepaintTextRainbowEnabled:
          debugRepaintTextRainbowEnabled ?? this.debugRepaintTextRainbowEnabled,
      debugPaintLayerBordersEnabled:
          debugPaintLayerBordersEnabled ?? this.debugPaintLayerBordersEnabled,
      debugInvertedOversizedImages:
          debugInvertedOversizedImages ?? this.debugInvertedOversizedImages,
      debugPaintBaselinesEnabled:
          debugPaintBaselinesEnabled ?? this.debugPaintBaselinesEnabled,
      debugRepaintRainbowEnabled:
          debugRepaintRainbowEnabled ?? this.debugRepaintRainbowEnabled,
      debugShowCheckedModeBanner:
          debugShowCheckedModeBanner ?? this.debugShowCheckedModeBanner,
      debugPaintPointersEnabled:
          debugPaintPointersEnabled ?? this.debugPaintPointersEnabled,
      showPerformanceOverlay:
          showPerformanceOverlay ?? this.showPerformanceOverlay,
      debugPaintSizeEnabled:
          debugPaintSizeEnabled ?? this.debugPaintSizeEnabled,
    );
  }
}
