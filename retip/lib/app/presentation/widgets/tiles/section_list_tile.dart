import 'package:flutter/material.dart';

class SectionListTile extends StatelessWidget {
  final String text;

  const SectionListTile(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
