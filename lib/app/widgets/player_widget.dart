import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/core/asset/retip_asset.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    final player = GetIt.instance.get<RetipAudio>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              // if (player.showMiniplayer == false) {
              //   return const SizedBox();
              // }

              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlayerView(player: player),
                  ),
                ),
                // onHorizontalDragEnd: (details) {
                //   if ((details.primaryVelocity ?? 0.0) > 0.0) {
                //     player.previous();
                //   }

                //   if ((details.primaryVelocity ?? 0.0) < 0.0) {
                //     player.next();
                //   }
                // },
                child: Dismissible(
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      await player.previous();
                    } else if (direction == DismissDirection.endToStart) {
                      await player.next();
                    }
                    return false;
                  },
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      await player.next();
                    } else if (direction == DismissDirection.endToStart) {
                      await player.previous();
                    }
                  },
                  background: Container(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const HorizontalSpacer(),
                        const RpIconButton.filledTonal(
                            icon: Icons.skip_previous),
                        const HorizontalSpacer(),
                        Text(
                          'Previous',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Next',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const HorizontalSpacer(),
                        const RpIconButton.filledTonal(icon: Icons.skip_next),
                        const HorizontalSpacer(),
                      ],
                    ),
                  ),
                  key: const ValueKey('current'),
                  child: Container(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    width: double.infinity,
                    // height: (24 * 2) + 16,
                    child: Column(
                      children: [
                        StreamBuilder(
                          stream: player.positionStream,
                          builder: (context, snapshot) {
                            final duration = player.duration?.inSeconds;
                            final progress = player.position.inSeconds;

                            return Row(
                              children: [
                                Expanded(
                                  flex: progress,
                                  child: Container(
                                    height: 4,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Expanded(
                                  flex: (duration ?? progress) - progress,
                                  child: Container(
                                    height: 4,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  PlayerArtworkWidget(player: player),
                                  const SizedBox(width: Sizer.x1),
                                  Expanded(
                                      child: AudioInfoWidget(player: player)),
                                ],
                              ),
                            ),
                            const HorizontalSpacer(),
                            const IconButton(
                              icon: Icon(Icons.shuffle),
                              onPressed: null,
                            ),
                            const PlayPauseIcon(
                              size: 24,
                            ),
                            const HorizontalSpacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ],
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                track?.title ?? RetipL10n.of(context).unknownTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                track?.artist ?? RetipL10n.of(context).unknownArtist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        });
  }
}

class PlayerArtworkWidget extends StatelessWidget {
  const PlayerArtworkWidget({
    required this.player,
    super.key,
  });

  final RetipAudio player;

  @override
  Widget build(BuildContext context) {
    const double size = 24 * 2 + 16;

    return StreamBuilder<int?>(
      stream: player.currentIndexStream,
      builder: (context, snapshot) {
        final index = snapshot.data ?? 0;
        final track = (index >= 0 && index < player.tracks.length)
            ? player.tracks[index]
            : null;

        return LayoutBuilder(builder: (context, constraints) {
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
        });
      },
    );
  }
}
