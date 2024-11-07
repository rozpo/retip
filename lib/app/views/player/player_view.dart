import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:retip/app/services/cases/favourites/add_to_favourites.dart';
import 'package:retip/app/services/cases/favourites/is_in_favourites.dart';
import 'package:retip/app/services/cases/favourites/remove_from_favourites.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/extensions/duration_extension.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerView extends StatefulWidget {
  final RetipAudio player;

  const PlayerView({
    required this.player,
    super.key,
  });

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  TrackEntity? currentTrack;
  bool isFavourite = false;
  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    currentIndex = widget.player.currentIndex;

    currentTrack =
        currentIndex != null ? widget.player.tracks[currentIndex!] : null;

    if (currentTrack != null) {
      isFavourite = IsInFavourites.call(currentTrack!);
    }

    return StreamBuilder<int?>(
        stream: widget.player.currentIndexStream,
        builder: (context, snapshot) {
          currentIndex = widget.player.currentIndex;

          currentTrack =
              currentIndex != null ? widget.player.tracks[currentIndex!] : null;

          if (currentTrack != null) {
            isFavourite = IsInFavourites.call(currentTrack!);
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    if (currentTrack != null) {
                      if (isFavourite) {
                        RemoveFromFavourites.call(currentTrack!);
                      } else {
                        AddToFavourites.call(currentTrack!);
                      }

                      setState(() {});
                    }
                  },
                  icon: Icon(
                    currentTrack != null && isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        context: context,
                        builder: (context) {
                          return ListView.builder(
                            itemCount: widget.player.tracks.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding:
                                const EdgeInsets.symmetric(vertical: Sizer.x1),
                            itemBuilder: (context, index) {
                              final track = widget.player.tracks[index];

                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: Sizer.x1),
                                leading: SizedBox.square(
                                  dimension: Sizer.x5,
                                  child: ArtworkWidget(
                                    bytes: track.artwork,
                                    borderWidth: 0,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(track.duration.text),
                                    IconButton(
                                      style: Theme.of(context)
                                          .iconButtonTheme
                                          .style,
                                      onPressed: null,
                                      icon: const Icon(Icons.more_vert),
                                    ),
                                  ],
                                ),
                                title: Text(track.title, maxLines: 1),
                                subtitle: Text(track.artist, maxLines: 1),
                                onTap: () async {
                                  Navigator.of(context).pop();

                                  await widget.player.seekToIndex(index);
                                  await widget.player.play();
                                },
                              );
                            },
                          );
                        });

                    setState(() {});
                  },
                  icon: const Icon(Icons.queue_music),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizer.x2,
                horizontal: Sizer.x4,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PlayerArtworkWidget(player: widget.player),
                  const SizedBox(
                    height: Sizer.x2,
                  ),
                  AudioInfoWidget(player: widget.player),
                ],
              ),
            ),
          );
        });
  }
}

class PlaylistBottomSheet extends StatefulWidget {
  final RetipAudio player;

  const PlaylistBottomSheet({
    required this.player,
    super.key,
  });

  @override
  State<PlaylistBottomSheet> createState() => _PlaylistBottomSheetState();
}

class _PlaylistBottomSheetState extends State<PlaylistBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: widget.player.tracks.length,
          itemBuilder: (context, index) {
            final prefs = GetIt.I.get<SharedPreferences>();
            final favouriteTracks =
                prefs.getStringList('favourite_tracks') ?? [];

            final track = widget.player.tracks[index];
            track.isFavourite = favouriteTracks.contains(track.id.toString());

            return ListTile(
              leading: Text(track.index.toString().padLeft(2, '0')),
              title: Text(track.title),
              subtitle: Text(track.artist),
              trailing: IconButton(
                onPressed: () async {
                  if (track.isFavourite) {
                    favouriteTracks.remove(track.id.toString());
                  } else {
                    favouriteTracks.add(track.id.toString());
                  }

                  await prefs.setStringList(
                      'favourite_tracks', favouriteTracks);

                  setState(() {});
                },
                icon: Icon(
                  track.isFavourite ? Icons.favorite : Icons.favorite_border,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                await widget.player.seekToIndex(index);
              },
            );
          }),
    );
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

class ProgressBar extends StatelessWidget {
  final RetipAudio player;

  const ProgressBar({required this.player, super.key});

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

class PlaybackButtons extends StatelessWidget {
  const PlaybackButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final player = GetIt.instance.get<RetipAudio>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        IconButton.filledTonal(
          onPressed: () => player.seekToPrevious(),
          icon: const Icon(Icons.skip_previous),
        ),
        const PlayPauseIcon(size: Sizer.x5),
        IconButton.filledTonal(
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
