import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/views/home/pages/album/album_page.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/utils.dart';

import 'abstract_entity.dart';
import 'track_entity.dart';

abstract class AlbumEntity extends AbstractEntity {
  final String title;
  final Uint8List? artwork;
  final String year;

  final List<TrackEntity> tracks;
  final ArtistEntity? artist;

  AlbumEntity({
    required this.title,
    required this.artist,
    required this.artwork,
    required this.tracks,
    this.year = '2024',
  });

  @override
  String toString() {
    return title;
  }

  @override
  String toTypeString(BuildContext context) {
    return RetipL10n.of(context).albums;
  }

  @override
  ListTile toListTile(BuildContext context, [String? query]) {
    return ListTile(
      title: query != null
          ? RetipUtils.getQueryText(context, title, query)
          : Text(title),
      subtitle: artist != null ? Text(artist!.name) : null,
      leading: artwork != null ? ArtworkWidget(bytes: artwork) : null,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AlbumPage(album: this);
            },
          ),
        );
      },
    );
  }
}
