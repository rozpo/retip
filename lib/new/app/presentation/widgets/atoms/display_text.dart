import 'package:flutter/material.dart';

class DisplayText extends StatelessWidget {
  final String data;

  const DisplayText(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      style: Theme.of(context).textTheme.displayMedium,
      data,
    );
  }
}
