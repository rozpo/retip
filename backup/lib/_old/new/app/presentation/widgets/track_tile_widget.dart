import 'package:flutter/material.dart';

import '../../../../../../../last/app/domain/entities/track_entity.dart';
import '../../../widgets/atoms/text_widget.dart';

class TrackTileWidget extends StatelessWidget {
  final TrackEntity track;

  const TrackTileWidget(
    this.track, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.music_note),
      title: TextWidget.short(track.title),
      subtitle: TextWidget.short(track.artist?.name ?? ''),
      onTap: () {
        // TrackOptions(track).show(context);
      },
    );
  }
}
