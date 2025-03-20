import 'package:flutter/material.dart';

class PlayerArtworkWidget extends StatelessWidget {
  const PlayerArtworkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;

        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child: Icon(
            Icons.music_note,
            size: size / 2,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
