import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/audio/audio_bloc.dart';
import '../blocs/track/track_bloc.dart';
import '../widgets/organisms/sheets/track_sheet_widget.dart';
import '../widgets/organisms/track_tile_widget.dart';

class TracksView extends StatelessWidget {
  const TracksView({super.key});

  @override
  Widget build(BuildContext context) {
    final audioBloc = BlocProvider.of<AudioBloc>(context);

    return BlocBuilder<TrackBloc, TrackState>(
      builder: (context, state) {
        if (state is TrackInitial) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.tracks.length,
            itemBuilder: (context, index) {
              final track = state.tracks[index];

              return TrackTileWidget(
                onTap: () => audioBloc.add(AudioPlay(state.tracks, index)),
                onActionTap: () => TrackSheetWidget(track).show(context),
                track,
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
