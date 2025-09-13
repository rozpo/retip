import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/enitities/track_entity.dart';
import '../../domain/services/audio_service.dart';
import '../widgets/tiles/track_list_tile_widget.dart';

class TracksView extends StatelessWidget {
  final List<TrackEntity> tracks;

  const TracksView(this.tracks, {super.key});

  @override
  Widget build(BuildContext context) {
    final audioService = RepositoryProvider.of<AudioService>(context);

    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];

        return TrackListTileWidget(
          onTap: () => audioService.setQueue(tracks, index: index),
          track,
        );
      },
    );
  }
}
