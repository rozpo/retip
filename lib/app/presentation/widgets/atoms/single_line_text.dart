import 'package:flutter/material.dart';

class SingleLineText extends StatelessWidget {
  final TextAlign? textAlign;
  final TextStyle? style;
  final String text;

  const SingleLineText(
    this.text, {
    this.textAlign,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: style,
      maxLines: 1,
      text,
    );
  }
}
