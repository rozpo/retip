import 'package:flutter/material.dart';

import '../../../domain/entities/track_entity.dart';
import '../molecules/list_tile_widget.dart';

class TracksListWidget extends StatelessWidget {
  final List<TrackEntity> tracks;

  const TracksListWidget({
    required this.tracks,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];

        return ListTileWidget(
          tileIcon: Icons.music_note,
          title: track.title,
          subtitle: track.artist?.name,
        );
      },
    );
  }
}
