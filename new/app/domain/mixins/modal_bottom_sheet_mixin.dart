import 'package:flutter/material.dart';

mixin ModalBottomSheetMixin on Widget {
  Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      useRootNavigator: true,
      useSafeArea: true,
      context: context,
      builder: (context) => this,
    );
  }
}
