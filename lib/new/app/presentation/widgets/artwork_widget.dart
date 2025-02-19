import 'dart:io';

import 'package:flutter/material.dart';

class ArtworkWidget extends StatelessWidget {
  final String? path;

  const ArtworkWidget(
    this.path, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Image.file(
          File(path ?? ''),
          cacheHeight: (height * 4).toInt(),
          cacheWidth: (width * 4).toInt(),
          fit: BoxFit.cover,
          width: width,
          height: height,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }

            return AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: frame == null ? 0 : 1,
              curve: Curves.easeOut,
              child: child,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.music_note);
          },
        );
      },
    );
  }
}
