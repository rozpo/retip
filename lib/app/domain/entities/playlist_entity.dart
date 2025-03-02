import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'abstract_entity.dart';
import 'track_entity.dart';
import '../../presentation/pages/playlist/playlist_page.dart';
import '../../presentation/widgets/atoms/playlist_artwork.dart';
import '../../presentation/widgets/atoms/single_line_text.dart';
import '../../../core/l10n/retip_l10n.dart';
import '../../../core/utils/sizer.dart';
import '../../../core/utils/utils.dart';

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
        child: PlaylistArtwork(
          images: artworks,
        ),
      ),
      title: RetipUtils.getQueryText(context, name, query ?? ''),
      subtitle:
          SingleLineText(RetipL10n.of(context).tracksCount(tracks.length)),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PlaylistPage(playlist: this);
            },
          ),
        );
      },
    );
  }
}
