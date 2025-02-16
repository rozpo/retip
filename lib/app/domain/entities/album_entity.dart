import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../presentation/pages/album/album_page.dart';
import '../../presentation/widgets/atoms/artwork_widget.dart';
import '../../../core/l10n/retip_l10n.dart';
import '../../../core/utils/sizer.dart';
import '../../../core/utils/utils.dart';

import 'abstract_entity.dart';
import 'track_entity.dart';

abstract class AlbumEntity extends AbstractEntity {
  final String title;
  final Uint8List? artwork;
  final String? year;

  final List<TrackEntity> tracks;
  final String artist;
  final int? artistId;

  AlbumEntity({
    required super.id,
    required this.title,
    required this.artist,
    this.artistId,
    required this.artwork,
    required this.tracks,
    this.year,
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
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        width: Sizer.x5,
        height: Sizer.x5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizer.x0_5),
          color: theme.colorScheme.surfaceBright,
        ),
        child: ArtworkWidget(
          bytes: artwork,
          borderWidth: 0,
        ),
      ),
      title: RetipUtils.getQueryText(context, title, query ?? ''),
      subtitle: Text(artist),
      onTap: () {
        Navigator.of(context).push(
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
