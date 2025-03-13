import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/track_entity.dart';
import '../../blocs/playlist/playlist_bloc.dart';
import '../../views/playlists_view.dart';
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
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTileWidget(
          subtitle: track.artist?.name,
          tileIcon: Icons.music_note,
          title: track.title,
          actionIcon: Icons.info,
          onActionTap: () {
            Navigator.pop(context);
          },
        ),
        const DividerWidget(),
        Expanded(
          child: PlaylistsView(
            showFab: false,
            onTap: (playlistId) => context.read<PlaylistBloc>().add(
                  PlaylistAddTrack(playlistId, track.id),
                ),
          ),
        ),
      ],
    );
  }
}
