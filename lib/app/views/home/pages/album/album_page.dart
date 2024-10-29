import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/player/player_widget.dart';
import 'package:retip/app/widgets/sort_button.dart';
import 'package:retip/app/widgets/spacer.dart' hide Spacer;
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:retip/core/extensions/duration_extension.dart';

class AlbumPage extends StatefulWidget {
  final AlbumEntity album;

  const AlbumPage({
    required this.album,
    super.key,
  });

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final RetipAudio player = GetIt.I.get();

  SortMode sortMode = SortMode.numerically;

  @override
  void initState() {
    sortMode = SortMode.numerically;

    widget.album.tracks.sort((a, b) {
      return a.index?.compareTo(b.index ?? 0) ?? 0;
    });

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

              widget.album.tracks.sort((a, b) {
                return a.title.compareTo(b.title);
              });

              setState(() {});
              Navigator.pop(context);
            },
            sortByNum: () {
              sortMode = SortMode.numerically;

              widget.album.tracks.sort((a, b) {
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
        itemCount: widget.album.tracks.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: ArtworkWidget(bytes: widget.album.artwork)),
                      const HorizontalSpacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.album.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const VerticalSpacer(),
                            Text(widget.album.artist),
                            const VerticalSpacer(),
                            Text(
                              '${RetipL10n.of(context).tracks}: ${widget.album.tracks.length}',
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
                  const SizedBox(height: Sizer.x2),
                  Row(
                    children: [
                      const Icon(Icons.queue_music),
                      const HorizontalSpacer(),
                      Text(
                        RetipL10n.of(context).tracks,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          final track = widget.album.tracks[index - 1];

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
            leading: Container(
              width: Sizer.x5,
              height: Sizer.x5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizer.x0_5),
                color: Theme.of(context).colorScheme.surfaceBright,
              ),
              child: Center(
                child: Text(
                  track.index.toString().padLeft(2, '0'),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
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

              await player.playlistAddAll(widget.album.tracks);
              await player.seekToIndex(index - 1);
              await player.play();
            },
          );
        },
      ),
    );
  }
}
