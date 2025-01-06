import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:retip/app/domain/entities/abstract_entity.dart';
import 'package:retip/app/domain/entities/track_entity.dart';
import 'package:retip/app/presentation/views/playlist/playlist_view.dart';
import 'package:retip/app/presentation/widgets/playlist_artwork.dart';
import 'package:retip/app/presentation/widgets/rp_list_tile.dart';
import 'package:retip/app/presentation/widgets/rp_text.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:retip/core/utils/utils.dart';

class PlaylistEntity extends AbstractEntity {
  String name;
  List<TrackEntity> tracks;

  PlaylistEntity({
    required super.id,
    required this.name,
    this.tracks = const [],
  });

  Uint8List? get artwork {
    for (final track in tracks) {
      if (track.artwork != null) {
        return track.artwork;
      }
    }
    return null;
  }

  List<Uint8List> get artworks {
    final result = <Uint8List>{};

    for (final track in tracks) {
      if (track.artwork != null) {
        result.add(track.artwork!);

        if (result.length >= 4) {
          break;
        }
      }
    }

    return result.toList();
  }

  @override
  String toTypeString(BuildContext context) {
    return RetipL10n.of(context).playlists;
  }

  @override
  RpListTile toListTile(BuildContext context, [String? query]) {
    final theme = Theme.of(context);

    return RpListTile(
      leading: Container(
        width: Sizer.x5,
        height: Sizer.x5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizer.x0_5),
          color: theme.colorScheme.surfaceBright,
        ),
        child: PlaylistArtwork(
          images: artworks,
        ),
      ),
      title: RetipUtils.getQueryText(context, name, query ?? ''),
      subtitle: RpText(RetipL10n.of(context).tracksCount(tracks.length)),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PlaylistView(playlist: this);
            },
          ),
        );
      },
    );
  }
}
