import 'package:flutter/material.dart';

class BottomPlayerWidget extends StatelessWidget {
  const BottomPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      height: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  height: 1,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
              ),
            ],
          ),
          const Expanded(
            child: Column(
              children: [
                Text('Title'),
                Text('Artist'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
