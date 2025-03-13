import 'package:flutter/material.dart';

import '../../../domain/entities/playlist_entity.dart';
import '../molecules/list_tile_widget.dart';

class PlaylistTileWidget extends StatelessWidget {
  final VoidCallback? onActionTap;
  final PlaylistEntity playlist;
  final VoidCallback? onTap;

  const PlaylistTileWidget(
    this.playlist, {
    this.onActionTap,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      subtitle: playlist.tracks.length.toString(),
      actionIcon: Icons.more_vert,
      tileIcon: Icons.playlist_play,
      onActionTap: onActionTap,
      title: playlist.name,
      onTap: onTap,
    );
  }
}
