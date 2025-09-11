import 'package:flutter/material.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';

class TrackListTileWidget extends StatelessWidget {
  final TrackEntity track;
  final VoidCallback? onTap;

  const TrackListTileWidget(this.track, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SingleLineTextWidget(track.title),
      subtitle: SingleLineTextWidget(track.artist),
      leading: Card(
        child: SizedBox.square(dimension: 40, child: Icon(Icons.music_note)),
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      onTap: onTap,
    );
  }
}
