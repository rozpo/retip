import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:retip/core/asset/retip_asset.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class PlayerView extends StatelessWidget {
  final RetipAudio player;

  const PlayerView({
    required this.player,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(),
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ArtworkWidget(player: player),
            AudioInfoWidget(player: player),
          ],
        ),
      ),
    );
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
    return StreamBuilder<int?>(
      stream: player.currentIndexStream,
      builder: (context, snapshot) {
        final index = snapshot.data ?? 0;
        final track = player.tracks[index];

        return SizedBox.square(
          dimension: MediaQuery.of(context).size.width / 1.25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: track.artwork != null
                ? Image.memory(
                    track.artwork!,
                    width: 500,
                    height: 500,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    RetipAsset.logo,
                    width: 500,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
          ),
        );
      },
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
          final track = (index >= 0 && index < player.tracks.length)
              ? player.tracks[index]
              : null;

          return Column(
            children: [
              Text(
                track?.title ?? RetipL10n.of(context).unknownTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                track?.album ?? RetipL10n.of(context).unknownAlbum,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(track?.artist ?? RetipL10n.of(context).unknownArtist),
              ProgressBar(player: player),
              const PlaybackButtons(),
            ],
          );
        });
  }
}

class ProgressBar extends StatelessWidget {
  final RetipAudio player;

  const ProgressBar({required this.player, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StreamBuilder<Duration>(
            stream: player.positionStream,
            builder: (context, snapshot) {
              final Duration position = snapshot.data ?? Duration.zero;
              return Text(durationToString(position));
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
              return Text(durationToString(duration));
            },
          ),
        ],
      ),
    );
  }

  String durationToString(Duration duration) {
    final String hours = (duration.inHours % 24).toString();
    final String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '${duration.inHours > 1 ? '$hours:' : ''}$minutes:$seconds';
  }
}

class PlaybackButtons extends StatelessWidget {
  const PlaybackButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final player = GetIt.instance.get<RetipAudio>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StreamBuilder<bool>(
          stream: player.shuffleModeEnabledStream,
          builder: (context, snapshot) {
            final enabled = snapshot.data ?? false;

            return IconButton(
              onPressed: () => player.setShuffleModeEnabled(!enabled),
              icon: Icon(
                Icons.shuffle,
                color: enabled
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            );
          },
        ),
        IconButton(
          onPressed: () => player.seekToPrevious(),
          icon: const Icon(Icons.skip_previous),
        ),
        const PlayPauseIcon(),
        IconButton(
          onPressed: () => player.seekToNext(),
          icon: const Icon(Icons.skip_next),
        ),
        StreamBuilder<LoopMode>(
          stream: player.loopModeStream,
          builder: (context, snapshot) {
            final loopMode = snapshot.data ?? LoopMode.off;
            final index = LoopMode.values.indexOf(loopMode) + 1;
            final nextIndex = index >= LoopMode.values.length ? 0 : index;
            final nextLoopMode = LoopMode.values[nextIndex];

            final IconData iconData;
            final Color iconColor;
            switch (loopMode) {
              case LoopMode.all:
                iconData = Icons.repeat_on;
                iconColor = Theme.of(context).colorScheme.primary;
                break;
              case LoopMode.one:
                iconData = Icons.repeat_one_on_sharp;
                iconColor = Theme.of(context).colorScheme.primary;
                break;
              case LoopMode.off:
                iconData = Icons.repeat;
                iconColor = Theme.of(context).colorScheme.onSurface;
                break;
            }

            return IconButton(
              onPressed: () => player.setLoopMode(nextLoopMode),
              icon: Icon(
                iconData,
                color: iconColor,
              ),
            );
          },
        ),
      ],
    );
  }
}

class PlayPauseIcon extends StatefulWidget {
  final double size;

  const PlayPauseIcon({
    this.size = 32,
    super.key,
  });

  @override
  State<PlayPauseIcon> createState() => _PlayPauseIconState();
}

class _PlayPauseIconState extends State<PlayPauseIcon>
    with SingleTickerProviderStateMixin {
  final player = GetIt.instance.get<RetipAudio>();

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: player.playingStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          snapshot.requireData ? controller.forward() : controller.reverse();
        }

        return IconButton.filled(
          onPressed: () => player.playing ? player.pause() : player.play(),
          icon: AnimatedIcon(
            size: widget.size,
            icon: AnimatedIcons.play_pause,
            progress: animation,
          ),
        );
      },
    );
  }
}
