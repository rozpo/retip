import 'package:flutter/material.dart';

class BottomSheetMolecule extends StatelessWidget {
  final Widget header;
  final List<Widget> children;

  const BottomSheetMolecule({
    this.children = const [],
    required this.header,
    super.key,
  });

  Future<void> show(BuildContext context) async {
    return showModalBottomSheet(
      builder: (context) => this,
      useRootNavigator: true,
      useSafeArea: true,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
