import 'package:flutter/material.dart';

class RpChip extends StatelessWidget {
  final String text;

  const RpChip({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      // avatar: Icon(Icons.history),
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
