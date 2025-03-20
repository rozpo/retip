import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/audio/audio_bloc.dart';

class PlayerProgressBarWidget extends StatelessWidget {
  const PlayerProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        final progress = state.position.inSeconds / state.duration.inSeconds;

        return Column(
          children: [
            Slider(
              value: progress.clamp(0, 1),
              onChanged: (value) {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(state.position.toString()),
                Text(state.duration.toString()),
              ],
            ),
          ],
        );
      },
    );
  }
}
