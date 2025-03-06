import 'package:flutter/material.dart';
import '../../../../../core/extensions/duration_extension.dart';

import '../../../../data/providers/just_audio_provider.dart';

class ProgressBar extends StatelessWidget {
  final JustAudioProvider player;

  const ProgressBar({
    required this.player,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StreamBuilder<Duration>(
          stream: player.positionStream,
          builder: (context, snapshot) {
            final Duration position = snapshot.data ?? Duration.zero;
            return Text(position.text);
          },
        ),
        Expanded(
          child: StreamBuilder<Duration>(
            stream: player.positionStream,
            builder: (context, snapshot) {
              final Duration position = snapshot.data ?? Duration.zero;
              final Duration duration = player.duration ?? Duration.zero;

              return Slider(
                value: position.inSeconds.toDouble(),
                max: duration.inSeconds.toDouble(),
                onChanged: (value) {
                  player.seek(Duration(seconds: value.toInt()));
                },
              );
            },
          ),
        ),
        StreamBuilder<Duration?>(
          stream: player.durationStream,
          builder: (context, snapshot) {
            final Duration duration = snapshot.data ?? Duration.zero;
            return Text(duration.text);
          },
        ),
      ],
    );
  }
}
