import 'package:flutter/material.dart';

import '../../../../../../../last/app/domain/entities/track_entity.dart';

class ListTileWidget extends StatelessWidget {
  final String? subtitle;
  final String title;

  const ListTileWidget._({
    required this.title,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.music_note),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      title: Text(title),
    );
  }

  factory ListTileWidget.track(TrackEntity track, {Key? key}) {
    return ListTileWidget._(
      subtitle: track.artist?.name,
      title: track.title,
      key: key,
    );
  }
}
