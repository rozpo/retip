import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/views/player/player_view.dart' hide ArtworkWidget;
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/core/audio/retip_audio.dart';

import 'abstract_entity.dart';

abstract class TrackEntity extends AbstractEntity {
  final int id;
  final String title;
  final String album;
  final String artist;
  final Uri uri;
  final Uint8List? artwork;
  final int? index;

  bool isFavourite = false;

  TrackEntity({
    required this.id,
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
  ListTile toListTile(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(artist),
      leading: artwork != null ? ArtworkWidget(bytes: artwork) : null,
      onTap: () {
        final player = GetIt.I.get<RetipAudio>();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PlayerView(player: player);
            },
          ),
        );
      },
    );
  }
}
