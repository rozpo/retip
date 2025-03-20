import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/audio/audio_bloc.dart';
import 'widgets/player_artwork_widget.dart';
import 'widgets/player_controls_widget.dart';
import 'widgets/player_progress_bar_widget.dart';
import 'widgets/player_track_info_widget.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        final currentTrack = state.currentTrack;

        if (currentTrack == null) return const SizedBox();

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          body: const Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PlayerArtworkWidget(),
                PlayerTrackInfoWidget(),
                PlayerProgressBarWidget(),
                PlayerControlsWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
