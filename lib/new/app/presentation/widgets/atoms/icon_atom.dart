import 'package:flutter/material.dart';

class IconAtom extends StatelessWidget {
  final IconData data;

  const IconAtom(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(data),
    );
  }
}
