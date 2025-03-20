import 'package:flutter/material.dart';

class PlayerActionsWidget extends StatelessWidget {
  const PlayerActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Chip(label: Text('Action $index'));
        },
      ),
    );
  }
}
