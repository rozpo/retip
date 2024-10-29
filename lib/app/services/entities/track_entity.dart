import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/views/player/player_view.dart'
    hide PlayerArtworkWidget;
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/utils.dart';

import 'abstract_entity.dart';

abstract class TrackEntity extends AbstractEntity {
  final int id;
  final int? albumId;
  final String title;
  final String album;
  final String artist;
  final Uri uri;
  final Uint8List? artwork;
  final int? index;

  bool isFavourite = false;

  TrackEntity({
    required this.id,
    this.albumId,
    required this.title,
    required this.album,
    required this.artist,
    required this.uri,
    required this.artwork,
    this.index,
  });

  @override
  String toString() {
    return title;
  }

  @override
  String toTypeString(BuildContext context) {
    return RetipL10n.of(context).tracks;
  }

  @override
  ListTile toListTile(BuildContext context, [String? query]) {
    return ListTile(
      title: query != null
          ? RetipUtils.getQueryText(context, title, query)
          : Text(title),
      subtitle: Text('$album\n$artist'),
      leading: artwork != null ? ArtworkWidget(bytes: artwork) : null,
      onTap: () async {
        final player = GetIt.I.get<RetipAudio>();

        await player.stop();
        await player.playlistAddAll([this]);
        await player.play();

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PlayerView(player: player);
              },
            ),
          );
        }
      },
    );
  }
}
