import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String data;

  const HeaderText(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      style: Theme.of(context).textTheme.headlineMedium,
      data,
    );
  }
}
