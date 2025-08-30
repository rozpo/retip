import 'package:flutter/material.dart';

import '../../domain/entities/track_entity.dart';

class TrackListTileWidget extends StatelessWidget {
  final TrackEntity track;

  const TrackListTileWidget({required this.track, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.music_note),
      title: Text(track.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        track.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
    );
  }
}
