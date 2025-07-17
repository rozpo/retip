import 'package:flutter/material.dart';

import '../../../domain/entites/track_entity.dart';
import '../modal_bottom_sheets/track_modal_bottom_sheet_widget.dart';

class TrackListTileWidget extends StatelessWidget {
  final TrackEntity track;
  final VoidCallback? onTap;

  const TrackListTileWidget({
    required this.track,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(track.title),
      subtitle: Text(track.artist),
      leading: const CircleAvatar(
        child: Icon(Icons.music_note_outlined),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          TrackModalBottomSheetWidget(track).show(context);
        },
      ),
    );
  }
}
