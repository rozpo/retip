import 'package:flutter/material.dart';

import '../../../domain/entities/track_entity.dart';
import '../molecules/list_tile_widget.dart';

class TracksListWidget extends StatelessWidget {
  final void Function(int index)? onActionTap;
  final void Function(int index)? onTap;
  final List<TrackEntity> tracks;
  final IconData? actionIcon;

  const TracksListWidget({
    required this.tracks,
    this.onActionTap,
    this.actionIcon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];

        return ListTileWidget(
          onActionTap: () => onActionTap?.call(index),
          actionIcon: actionIcon ?? Icons.more_vert,
          onTap: () => onTap?.call(index),
          subtitle: track.artist?.name,
          tileIcon: Icons.music_note,
          title: track.title,
        );
      },
    );
  }
}
