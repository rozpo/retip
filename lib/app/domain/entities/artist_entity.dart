import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:retip/app/views/artist/artist_view.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/rp_list_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:retip/core/utils/utils.dart';

import 'abstract_entity.dart';
import 'album_entity.dart';

abstract class ArtistEntity extends AbstractEntity {
  final String name;
  final Uint8List? artwork;
  final List<AlbumEntity> albums;

  ArtistEntity({
    required super.id,
    required this.name,
    required this.artwork,
    required this.albums,
  });

  @override
  String toString() {
    return name;
  }

  @override
  String toTypeString(BuildContext context) {
    return RetipL10n.of(context).artists;
  }

  @override
  RpListTile toListTile(BuildContext context, [String? query]) {
    final theme = Theme.of(context);

    int tracksLength = 0;

    for (final album in albums) {
      tracksLength += album.tracks.length;
    }

    return RpListTile(
      leading: Container(
        width: Sizer.x5,
        height: Sizer.x5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizer.max),
          color: theme.colorScheme.surfaceBright,
        ),
        child: ArtworkWidget(
          style: ArtworkStyle.circle,
          bytes: artwork,
          borderWidth: 0,
        ),
      ),
      title: RetipUtils.getQueryText(context, name, query ?? ''),
      subtitle: Text(
          '${RetipL10n.of(context).albumsCount(albums.length)} - ${RetipL10n.of(context).tracksCount(tracksLength)}'),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ArtistView(
                artist: this,
              );
            },
          ),
        );
      },
    );
  }
}
