part of 'dev_cubit.dart';

@immutable
final class DevState {
  final bool isEnabled;

  final bool invertOversizedImages;
  final bool repaintRainbowEnabled;

  const DevState({
    this.invertOversizedImages = false,
    this.repaintRainbowEnabled = false,
    this.isEnabled = !kReleaseMode,
  });

  DevState copyWith({
    bool? invertOversizedImages,
    bool? repaintRainbowEnabled,
    bool? isEnabled,
  }) {
    return DevState(
      isEnabled: isEnabled ?? this.isEnabled,
      invertOversizedImages:
          invertOversizedImages ?? this.invertOversizedImages,
      repaintRainbowEnabled:
          repaintRainbowEnabled ?? this.repaintRainbowEnabled,
    );
  }

  @override
  String toString() {
    return 'isEnabled = $isEnabled\n'
        'invertOversizedImages = $invertOversizedImages\n'
        'repaintRainbowEnabled = $repaintRainbowEnabled';
  }
}
