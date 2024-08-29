import 'package:flutter/material.dart';
import 'package:retip/core/utils/sizer.dart';

enum Direction {
  vertical,
  horizontal,
}

abstract class Spacer extends StatelessWidget {
  final Direction direction;

  const Spacer({required this.direction, super.key});

  @override
  Widget build(BuildContext context) {
    if (direction == Direction.vertical) {
      return const SizedBox(height: Sizer.x1);
    } else {
      return const SizedBox(width: Sizer.x1);
    }
  }
}

class VerticalSpacer extends Spacer {
  const VerticalSpacer({super.key}) : super(direction: Direction.vertical);
}

class HorizontalSpacer extends Spacer {
  const HorizontalSpacer({super.key}) : super(direction: Direction.horizontal);
}
