import 'package:flutter/material.dart';

class RpText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const RpText(
    this.text, {
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text,
      style: style,
    );
  }
}
