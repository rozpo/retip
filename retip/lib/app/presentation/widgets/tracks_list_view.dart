import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/tracks/tracks_bloc.dart';
import 'track_list_tile_widget.dart';

class TracksListView extends StatelessWidget {
  final TracksBloc tracksBloc;

  const TracksListView({super.key, required this.tracksBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TracksBloc, TracksState>(
      bloc: tracksBloc,
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.tracks.length,
          itemBuilder: (context, index) {
            final track = state.tracks[index];
            return TrackListTileWidget(track: track);
          },
        );
      },
    );
  }
}
