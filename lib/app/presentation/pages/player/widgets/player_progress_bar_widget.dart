import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/audio/audio_bloc.dart';

class PlayerProgressBarWidget extends StatelessWidget {
  const PlayerProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        final position = state.position;
        final duration = state.duration;

        return Column(
          children: [
            Slider(
              value: (position.inSeconds / duration.inSeconds).toDouble(),
              onChanged: (value) {},
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('00:00'),
                Text('00:00'),
              ],
            ),
          ],
        );
      },
    );
  }
}
