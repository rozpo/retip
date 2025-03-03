import 'package:flutter/material.dart';

import '../../../domain/entities/track_entity.dart';
import '../atoms/icon_button_widget.dart';

class TrackTileWidget extends StatelessWidget {
  final TrackEntity track;

  const TrackTileWidget(this.track, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.music_note),
      title: Text(track.title),
      subtitle: track.artist != null ? Text(track.artist!.name) : null,
      trailing: const IconButtonWidget(iconData: Icons.more_vert),
      onTap: () {},
    );
  }
}
