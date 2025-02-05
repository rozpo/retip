import 'package:flutter/material.dart';

import '../../../../data/providers/just_audio_provider.dart';
import '../../../widgets/atoms/artwork_widget.dart';

class PlayerArtworkWidget extends StatelessWidget {
  final JustAudioProvider player;

  const PlayerArtworkWidget({
    required this.player,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int?>(
      stream: player.currentIndexStream,
      builder: (context, snapshot) {
        final index = snapshot.data ?? 0;
        final track = (index >= 0 && index < player.tracks.length)
            ? player.tracks[index]
            : null;

        return ArtworkWidget(bytes: track?.artwork);
      },
    );
  }
}
