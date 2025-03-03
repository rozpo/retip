import 'package:flutter/material.dart';

import '../../views/tracks_view.dart';
import '../../widgets/atoms/content_padding.dart';
import '../../widgets/atoms/short_text_atom.dart';

class AlbumPage extends StatelessWidget {
  final String title;
  final int albumId;

  const AlbumPage({
    required this.albumId,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShortTextAtom(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
          const ContentPadding(),
        ],
      ),
      body: TracksView(albumId: albumId),
    );
  }
}
