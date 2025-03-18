import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/retip_l10n.dart';
import '../../../../core/router/retip_routes.dart';
import '../../../domain/entities/track_entity.dart';
import '../atoms/divider_widget.dart';
import '../molecules/list_tile_widget.dart';

class TrackSheetWidget extends StatelessWidget {
  final TrackEntity track;

  const TrackSheetWidget(
    this.track, {
    super.key,
  });

  Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      shape: const BeveledRectangleBorder(),
      builder: (context) => this,
      useRootNavigator: true,
      useSafeArea: true,
      context: context,
      scrollControlDisabledMaxHeightRatio: 0.9,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.read<RetipL10n>().of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTileWidget(
          subtitle: track.artist?.name,
          tileIcon: Icons.music_note,
          title: track.title,
          actionIcon: Icons.favorite_outline,
          onActionTap: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 8),
        const DividerWidget(),
        const SizedBox(height: 8),
        const ListTileWidget(
          tileIcon: Icons.playlist_play,
          title: 'Play next',
        ),
        const ListTileWidget(
          tileIcon: Icons.queue_music,
          title: 'Add to queue',
        ),
        const ListTileWidget(
          tileIcon: Icons.playlist_add,
          title: 'Save to playlist',
        ),
        const SizedBox(height: 8),
        const DividerWidget(),
        const SizedBox(height: 8),
        if (track.album != null) ...[
          ListTileWidget(
            tileIcon: Icons.album,
            title: l10n.goToAlbum,
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(
                pathParameters: {'id': track.album!.id.toString()},
                RetipRoutes.album,
              );
            },
          ),
        ],
        if (track.artist != null) ...[
          ListTileWidget(
            tileIcon: Icons.person,
            title: l10n.goToArtist,
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(
                pathParameters: {'id': track.artist!.id.toString()},
                RetipRoutes.artist,
              );
            },
          ),
        ],
        const SizedBox(height: 8),
        const DividerWidget(),
        const SizedBox(height: 8),
        const ListTileWidget(
          tileIcon: Icons.info,
          title: 'Show track info',
        ),
        const ListTileWidget(
          tileIcon: Icons.visibility_off,
          title: 'Hide track',
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
