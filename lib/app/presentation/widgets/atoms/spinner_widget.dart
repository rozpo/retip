import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/utils/sizer.dart';

class SpinnerWidget extends StatelessWidget {
  const SpinnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SpinKitWave(
      size: Sizer.x4,
      color: colorScheme.onSurface,
      type: SpinKitWaveType.center,
    );
  }
}
