import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/track_entity.dart';
import '../blocs/playlist/playlist_bloc.dart';
import '../views/playlists_view.dart';

class TrackBottomSheet extends StatelessWidget {
  final TrackEntity track;

  const TrackBottomSheet(
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
    return PlaylistsView(
      showFab: false,
      onTap: (playlistId) => context.read<PlaylistBloc>().add(
            PlaylistAddTrack(playlistId, track.id),
          ),
    );
  }
}
