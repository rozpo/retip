import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/retip_l10n.dart';
import '../../../../../core/router/retip_routes.dart';
import '../../../../../core/utils/show_bottom_sheet_action.dart';
import '../../../../domain/entities/track_entity.dart';
import '../../../../domain/repositories/track_repository.dart';
import '../../atoms/divider_widget.dart';
import '../../atoms/spacer_widget.dart';
import '../../molecules/list_tile_widget.dart';

class TrackSheetWidget extends StatelessWidget with ShowBottomSheetAction {
  final TrackEntity track;

  const TrackSheetWidget(
    this.track, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.read<RetipL10n>().of(context);
    final album = track.album;
    final artist = track.artist;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTileWidget(
          subtitle: artist?.name,
          tileIcon: Icons.music_note,
          title: track.title,
          actionIcon:
              track.isFavorite ? Icons.favorite : Icons.favorite_outline,
          onActionTap: () {
            context.read<TrackRepository>().toggleFavorite(track);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  track.isFavorite
                      ? l10n.removedFromFavourites
                      : l10n.addedToFavourites,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        const DividerWidget(),
        const SizedBox(height: 8),
        ListTileWidget(
          tileIcon: Icons.playlist_play,
          title: l10n.playNext,
        ),
        ListTileWidget(
          tileIcon: Icons.queue_music,
          title: l10n.addToQueue,
        ),
        ListTileWidget(
          tileIcon: Icons.playlist_add,
          title: l10n.saveToPlaylist,
        ),
        if (artist != null || album != null) ...[
          const SpacerWidget(),
          const DividerWidget(),
          const SpacerWidget(),
        ],
        if (album != null) ...[
          ListTileWidget(
            tileIcon: Icons.album,
            title: l10n.goToAlbum,
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(
                pathParameters: {'id': '${album.id}'},
                RetipRoutes.album,
              );
            },
          ),
        ],
        if (artist != null) ...[
          ListTileWidget(
            tileIcon: Icons.person,
            title: l10n.goToArtist,
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(
                pathParameters: {'id': '${artist.id}'},
                RetipRoutes.artist,
              );
            },
          ),
        ],
        const SpacerWidget(),
        const DividerWidget(),
        const SpacerWidget(),
        ListTileWidget(
          tileIcon: Icons.info,
          title: l10n.showInfo,
        ),
        const SpacerWidget(),
      ],
    );
  }
}
