import 'package:flutter/material.dart';

import '../../../domain/entities/track_entity.dart';
import '../molecules/list_tile_widget.dart';

class TrackTileWidget extends StatelessWidget {
  final VoidCallback? onActionTap;
  final VoidCallback? onTap;
  final TrackEntity track;

  const TrackTileWidget(
    this.track, {
    this.onActionTap,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      subtitle: track.artist?.name,
      actionIcon: Icons.more_vert,
      tileIcon: Icons.music_note,
      onActionTap: onActionTap,
      title: track.title,
      onTap: onTap,
    );
  }
}
