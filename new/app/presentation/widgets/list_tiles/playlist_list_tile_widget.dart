import 'package:flutter/material.dart';

import '../../../domain/entites/playlist_entity.dart';
import '../modal_bottom_sheets/playlist_modal_bottom_sheet_widget.dart';

class PlaylistListTileWidget extends StatelessWidget {
  final PlaylistEntity playlist;
  final VoidCallback? onTap;

  const PlaylistListTileWidget({
    required this.playlist,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(playlist.name),
      leading: const CircleAvatar(
        child: Icon(Icons.queue_music_outlined),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          PlaylistModalBottomSheetWidget(playlist).show(context);
        },
      ),
    );
  }
}
