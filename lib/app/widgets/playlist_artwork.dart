import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/core/utils/sizer.dart';

class PlaylistArtwork extends StatelessWidget {
  final List<Uint8List> images;
  final IconData? icon;

  const PlaylistArtwork({
    this.images = const [],
    this.icon,
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
            child: images.isEmpty
                ? ArtworkWidget(icon: icon)
                : images.length < 4
                    ? Image.memory(images[0])
                    : Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Image.memory(images[0]),
                                Image.memory(images[1]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Image.memory(images[2]),
                                Image.memory(images[3]),
                              ],
                            ),
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }
}
