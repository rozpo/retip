import 'package:flutter/material.dart';

mixin ShowModalBottomSheetMixin on Widget {
  Future<T?> show<T>(BuildContext context) async {
    return await showModalBottomSheet<T>(
      builder: (context) => SafeArea(child: this),
      useRootNavigator: true,
      showDragHandle: false,
      useSafeArea: true,
      context: context,
    );
  }
}
