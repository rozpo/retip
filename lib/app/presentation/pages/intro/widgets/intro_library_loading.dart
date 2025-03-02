import 'package:flutter/material.dart';

class IntroLibraryLoading extends StatelessWidget {
  final double? progress;

  const IntroLibraryLoading({
    this.progress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LinearProgressIndicator(
        value: progress,
      ),
    );
  }
}
