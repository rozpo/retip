import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/data/providers/just_audio_provider.dart';
import 'package:retip/app/domain/repositories/audio_repository.dart';
import 'package:retip/app/presentation/views/player/player_view.dart';
import 'package:retip/app/presentation/views/settings/cubit/settings_cubit.dart';
import 'package:retip/app/presentation/widgets/artwork_widget.dart';
import 'package:retip/app/presentation/widgets/rp_icon_button.dart';
import 'package:retip/app/presentation/widgets/spacer.dart';
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
    final player = GetIt.instance.get<JustAudioProvider>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              return GestureDetector(
                onTap: player.tracks.isNotEmpty
                    ? () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PlayerView(player: player),
                          ),
                        )
                    : null,
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
                    child: BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            if (context
                                    .read<SettingsCubit>()
                                    .state
                                    .batterySaver ==
                                false) ...[
                              StreamBuilder(
                                stream: player.positionStream,
                                builder: (context, snapshot) {
                                  final position =
                                      snapshot.data ?? Duration.zero;
                                  final duration =
                                      player.duration ?? Duration.zero;

                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: position.inSeconds,
                                        child: Container(
                                          height: 4,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      Expanded(
                                        flex: duration.inSeconds -
                                            position.inSeconds,
                                        child: Container(
                                          height: 4,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ],
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const SizedBox(width: Sizer.x1),
                                      PlayerArtworkWidget(player: player),
                                      const SizedBox(width: Sizer.x1),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: Sizer.x1),
                                          child:
                                              AudioInfoWidget(player: player),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const HorizontalSpacer(),
                                PlayPauseIcon(
                                  disabled: player.tracks.isEmpty,
                                  size: 24,
                                ),
                                const HorizontalSpacer(),
                              ],
                            ),
                          ],
                        );
                      },
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

  final JustAudioProvider player;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int?>(
        stream: player.currentIndexStream,
        builder: (context, snapshot) {
          final index = snapshot.data ?? 0;
          final track = (index >= 0 && index < player.tracks.length)
              ? player.tracks[index]
              : null;

          GetIt.I.get<AudioRepository>().setTracksIndex(index);

          return SizedBox(
              height: Sizer.x5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: player.tracks.isNotEmpty
                    ? [
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
                      ]
                    : [
                        Text(
                          RetipL10n.of(context).nothingIsPlaying,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
              ));
        });
  }
}

class PlayerArtworkWidget extends StatelessWidget {
  const PlayerArtworkWidget({
    required this.player,
    super.key,
  });

  final JustAudioProvider player;

  @override
  Widget build(BuildContext context) {
    const double size = Sizer.x5;

    return StreamBuilder<int?>(
      stream: player.currentIndexStream,
      builder: (context, snapshot) {
        final index = snapshot.data ?? 0;
        final track = (index >= 0 && index < player.tracks.length)
            ? player.tracks[index]
            : null;

        return LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizer.x0_5),
              image: track?.artwork != null
                  ? DecorationImage(
                      image: Image.memory(
                      track!.artwork!,
                      // width: size,
                      // height: size,
                      fit: BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: track?.artwork == null ? const ArtworkWidget() : null,
          );
        });
      },
    );
  }
}
