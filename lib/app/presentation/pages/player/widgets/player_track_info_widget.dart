import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/audio/audio_bloc.dart';

class PlayerTrackInfoWidget extends StatelessWidget {
  const PlayerTrackInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        final track = state.currentTrack;

        return Column(
          children: [
            Text(
              track?.title ?? '',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(track?.artist?.name ?? '', style: textTheme.bodyLarge),
            Text(track?.album?.title ?? ''),
          ],
        );
      },
    );
  }
}
