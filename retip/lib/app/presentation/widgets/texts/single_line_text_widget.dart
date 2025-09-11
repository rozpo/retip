import 'package:flutter/material.dart';

class SingleLineTextWidget extends StatelessWidget {
  final String text;

  const SingleLineTextWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}
