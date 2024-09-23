import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/core/asset/retip_asset.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final player = GetIt.instance.get<RetipAudio>();

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PlayerView(player: player),
        ),
      ),
      onHorizontalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0.0) > 0.0) {
          player.previous();
        }

        if ((details.primaryVelocity ?? 0.0) < 0.0) {
          player.next();
        }
      },
      child: Container(
        color: Theme.of(context).colorScheme.surfaceBright,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ArtworkWidget(player: player),
                const SizedBox(width: 16),
                AudioInfoWidget(player: player),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: PlayPauseIcon(
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AudioInfoWidget extends StatelessWidget {
  const AudioInfoWidget({
    super.key,
    required this.player,
  });

  final RetipAudio player;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int?>(
        stream: player.currentIndexStream,
        builder: (context, snapshot) {
          final index = snapshot.data ?? 0;
          final track = (index >= 0 && index < player.tracks.length) ? player.tracks[index] : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                track?.title ?? RetipL10n.of(context).unknownTitle,
              ),
              Text(track?.artist ?? RetipL10n.of(context).unknownArtist),
            ],
          );
        });
  }
}

class ArtworkWidget extends StatelessWidget {
  const ArtworkWidget({
    required this.player,
    super.key,
  });

  final RetipAudio player;

  @override
  Widget build(BuildContext context) {
    const size = 60.0;

    return StreamBuilder<int?>(
      stream: player.currentIndexStream,
      builder: (context, snapshot) {
        final index = snapshot.data ?? 0;
        final track = (index >= 0 && index < player.tracks.length) ? player.tracks[index] : null;

        return SizedBox.square(
          dimension: size,
          child: track?.artwork != null
              ? Image.memory(
                  track!.artwork!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                )
              : SvgPicture.asset(
                  RetipAsset.logo,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
        );
      },
    );
  }
}
