import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/views/home/pages/album/album_page.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/player_widget.dart';
import 'package:retip/app/widgets/sort_button.dart';
import 'package:retip/app/widgets/spacer.dart' hide Spacer;
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/extensions/duration_extension.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class ArtistPage extends StatefulWidget {
  final ArtistEntity artist;

  const ArtistPage({
    required this.artist,
    super.key,
  });

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  final RetipAudio player = GetIt.I.get();

  SortMode sortMode = SortMode.numerically;

  final tracks = <TrackEntity>[];

  Duration duration = Duration.zero;

  @override
  void initState() {
    int seconds = 0;

    for (final album in widget.artist.albums) {
      album.tracks.sort((a, b) {
        return a.index?.compareTo(b.index ?? 0) ?? 0;
      });
      tracks.addAll(album.tracks);

      for (final track in album.tracks) {
        seconds += track.duration.inSeconds;
      }
    }

    duration = Duration(seconds: seconds);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          SortButton(
            sortMode: sortMode,
            sortByAlpha: () {
              sortMode = SortMode.alphabetically;

              tracks.sort((a, b) {
                return a.title.compareTo(b.title);
              });

              setState(() {});
              Navigator.pop(context);
            },
            sortByNum: () {
              sortMode = SortMode.numerically;

              tracks.sort((a, b) {
                return a.index?.compareTo(b.index ?? 0) ?? 0;
              });

              setState(() {});
              Navigator.pop(context);
            },
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.grid_view),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.more_vert),
          ),
          const HorizontalSpacer(),
        ],
      ),
      bottomNavigationBar: const PlayerWidget(),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
        physics: const BouncingScrollPhysics(),
        itemCount: tracks.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ArtworkWidget(
                          bytes: widget.artist.artwork,
                          style: ArtworkStyle.circle,
                        ),
                      ),
                      const HorizontalSpacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.artist.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const VerticalSpacer(),
                            Text(
                                '${RetipL10n.of(context).albums}: ${widget.artist.albums.length}'),
                            const VerticalSpacer(),
                            Text(
                              '${RetipL10n.of(context).tracks}: ${tracks.length}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const VerticalSpacer(),
                            Text(
                              '${RetipL10n.of(context).duration}: ${duration.text}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const Divider(),
                            Wrap(
                              children: [
                                IconButton.filledTonal(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite),
                                ),
                                IconButton.filledTonal(
                                  onPressed: () {},
                                  icon: const Icon(Icons.repeat),
                                ),
                                IconButton.filledTonal(
                                  onPressed: () {},
                                  icon: const Icon(Icons.shuffle),
                                ),
                                IconButton.filled(
                                  onPressed: () {},
                                  icon: const Icon(Icons.play_arrow),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: Sizer.x2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                  child: Row(
                    children: [
                      const Icon(Icons.album),
                      const HorizontalSpacer(),
                      Text(
                        RetipL10n.of(context).albums,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 3,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(Sizer.x1),
                    separatorBuilder: (context, index) =>
                        const HorizontalSpacer(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.artist.albums.length,
                    itemBuilder: (context, index) {
                      final album = widget.artist.albums[index];

                      return GestureDetector(
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AlbumPage(album: album);
                              },
                            ),
                          );

                          setState(() {});
                        },
                        child: SizedBox.square(
                          child: ArtworkWidget(bytes: album.artwork),
                        ),
                      );
                    },
                  ),
                ),
                const VerticalSpacer(),
                const VerticalSpacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                  child: Row(
                    children: [
                      const Icon(Icons.queue_music),
                      const HorizontalSpacer(),
                      Text(
                        RetipL10n.of(context).tracks,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          final track = tracks[index - 1];

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
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
                  style: Theme.of(context).iconButtonTheme.style,
                  onPressed: null,
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            title: Text(track.title, maxLines: 1),
            subtitle: Text(track.artist, maxLines: 1),
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlayerView(
                    player: player,
                  ),
                ),
              );

              await player.playlistAddAll(tracks);
              await player.seekToIndex(index - 1);
              await player.play();
            },
          );
        },
      ),
    );
  }
}
