import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retip/core/utils/sizer.dart';

enum ArtworkStyle {
  square,
  circle,
}

class ArtworkWidget extends StatelessWidget {
  final Uint8List? bytes;
  final ArtworkStyle style;
  final double borderWidth;

  const ArtworkWidget({
    this.bytes,
    this.style = ArtworkStyle.square,
    this.borderWidth = 4,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dimension = constraints.biggest.shortestSide;

        if (style == ArtworkStyle.square) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: borderWidth,
                color: Theme.of(context).colorScheme.surfaceBright,
              ),
              borderRadius: BorderRadius.circular(Sizer.x1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizer.x1 - borderWidth),
              child: bytes != null
                  ? Image.memory(
                      bytes!,
                      cacheHeight: 3 * dimension.toInt(),
                      cacheWidth: 3 * dimension.toInt(),
                    )
                  : Container(
                      width: dimension,
                      height: dimension,
                      color: Theme.of(context).colorScheme.surfaceBright,
                      child: const Icon(Icons.music_note),
                    ),
            ),
          );
        } else {
          return CircleAvatar(
            radius: dimension / 2,
            backgroundColor: Theme.of(context).colorScheme.surfaceBright,
            child: CircleAvatar(
              radius: dimension / 2 - borderWidth,
              backgroundImage: bytes != null
                  ? Image.memory(
                      bytes!,
                      cacheHeight: 3 * dimension.toInt(),
                      cacheWidth: 3 * dimension.toInt(),
                    ).image
                  : null,
              child: bytes == null ? const Icon(Icons.person) : null,
            ),
          );
        }
      },
    );
  }
}
