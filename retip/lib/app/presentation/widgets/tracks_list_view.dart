import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/blocs/tracks/tracks_bloc.dart';

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
            return ListTile(
              title: Text(track.title),
              subtitle: Text(track.artist),
            );
          },
        );
      },
    );
  }
}
