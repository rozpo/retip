import 'package:flutter/material.dart';

mixin ShowBottomSheetAction on Widget {
  Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.9,
      shape: const BeveledRectangleBorder(),
      builder: (context) => this,
      useRootNavigator: true,
      useSafeArea: true,
      context: context,
    );
  }
}
