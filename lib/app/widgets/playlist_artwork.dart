import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:retip/core/utils/sizer.dart';

class PlaylistArtwork extends StatelessWidget {
  final List<Uint8List> images;

  const PlaylistArtwork({
    this.images = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(Sizer.x1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizer.x1),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    if (images.isNotEmpty)
                      Expanded(
                          child: Image.memory(
                        images[0],
                        fit: BoxFit.cover,
                      )),
                    if (images.length > 1)
                      Expanded(
                        child: Image.memory(
                          images[1],
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
                if (images.length > 2)
                  Row(
                    children: [
                      if (images.length > 2)
                        Expanded(child: Image.memory(images[2])),
                      if (images.length > 3)
                        Expanded(child: Image.memory(images[3])),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
