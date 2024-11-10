import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/favourites/is_in_favourites.dart';
import 'package:retip/app/services/cases/play_audio.dart';
import 'package:retip/app/widgets/more/more_icon.dart';
import 'package:retip/app/widgets/rp_list_tile.dart';
import 'package:retip/app/widgets/rp_text.dart';
import 'package:retip/app/widgets/tiles/add_to_fav_tile.dart';
import 'package:retip/app/widgets/tiles/go_to_album_tile.dart';
import 'package:retip/app/widgets/tiles/go_to_artist_tile.dart';
import 'package:retip/app/widgets/tiles/remove_from_fav_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:retip/core/utils/utils.dart';

import 'abstract_entity.dart';

abstract class TrackEntity extends AbstractEntity {
  final int? albumId;
  final String title;
  final String album;
  final String artist;
  final int? artistId;
  final Uri uri;
  final Uint8List? artwork;
  final int? index;
  final Duration duration;

  bool isFavourite = false;

  TrackEntity({
    required super.id,
    this.albumId,
    required this.title,
    required this.album,
    required this.artist,
    this.artistId,
    required this.uri,
    required this.duration,
    this.artwork,
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
  RpListTile toListTile(BuildContext context, [String? query]) {
    final theme = Theme.of(context);

    return RpListTile(
      onTap: () => PlayAudio.call([this]),
      leading: Container(
        width: Sizer.x5,
        height: Sizer.x5,
        decoration: BoxDecoration(
          image: artwork != null
              ? DecorationImage(image: Image.memory(artwork!).image)
              : null,
          borderRadius: BorderRadius.circular(Sizer.x0_5),
          color: theme.colorScheme.surfaceBright,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MoreIcon.horizontal(
            title: title,
            subtitle: artist,
            image: artwork,
            tiles: [
              IsInFavourites.call(this)
                  ? RemoveFromFavTile(
                      this,
                    )
                  : AddToFavTile(this),
              if (albumId != null) GoToAlbumTile(albumId!),
              if (artistId != null) GoToArtistTile(artistId!),
            ],
          ),
        ],
      ),
      title: RetipUtils.getQueryText(context, title, query ?? ''),
      subtitle: RpText(
        artist,
      ),
    );
  }
}
