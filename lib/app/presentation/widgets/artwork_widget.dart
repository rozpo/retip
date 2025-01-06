import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retip/core/utils/sizer.dart';

enum ArtworkStyle {
  square,
  circle,
}

class ArtworkWidget extends StatelessWidget {
  final double borderWidth;
  final ArtworkStyle style;
  final Uint8List? bytes;
  final IconData? icon;

  const ArtworkWidget({
    this.style = ArtworkStyle.square,
    this.borderWidth = 4,
    this.bytes,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dimension = constraints.biggest.shortestSide;

        if (style == ArtworkStyle.square) {
          return Container(
            height: dimension,
            width: dimension,
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
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: dimension,
                      height: dimension,
                      color: Theme.of(context).colorScheme.surfaceBright,
                      child: Icon(
                        icon ?? Icons.music_note,
                        size: dimension / 2,
                      ),
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
              child: bytes == null
                  ? Icon(
                      icon ?? Icons.person,
                      size: dimension / 2,
                    )
                  : null,
            ),
          );
        }
      },
    );
  }
}
