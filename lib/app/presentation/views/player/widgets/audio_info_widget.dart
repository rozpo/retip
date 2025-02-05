import 'package:flutter/material.dart';

import '../../../../../core/l10n/retip_l10n.dart';
import '../../../../../core/utils/sizer.dart';
import '../../../../data/providers/just_audio_provider.dart';
import 'playback_buttons.dart';
import 'progress_bar.dart';

class AudioInfoWidget extends StatelessWidget {
  final JustAudioProvider player;

  const AudioInfoWidget({
    super.key,
    required this.player,
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

          return Column(
            children: [
              Text(
                track?.title ?? RetipL10n.of(context).unknownTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                track?.album ?? RetipL10n.of(context).unknownAlbum,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                track?.artist ?? RetipL10n.of(context).unknownArtist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: Sizer.x2,
              ),
              ProgressBar(player: player),
              const SizedBox(
                height: Sizer.x2,
              ),
              const PlaybackButtons(),
            ],
          );
        });
  }
}
