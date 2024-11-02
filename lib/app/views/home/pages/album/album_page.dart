import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/favourites/add_to_favourites.dart';
import 'package:retip/app/services/cases/favourites/is_in_favourites.dart';
import 'package:retip/app/services/cases/favourites/remove_from_favourites.dart';
import 'package:retip/app/services/cases/play_audio.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/buttons/favourite_button.dart';
import 'package:retip/app/widgets/player_widget.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/app/widgets/sort_button.dart';
import 'package:retip/app/widgets/spacer.dart' hide Spacer;
import 'package:retip/app/widgets/track_tile.dart';
import 'package:retip/app/widgets/tracks_header.dart';
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
  SortMode sortMode = SortMode.numerically;
  Duration duration = Duration.zero;

  @override
  void initState() {
    int seconds = 0;

    for (final track in widget.album.tracks) {
      seconds += track.duration.inSeconds;
    }

    duration = Duration(seconds: seconds);

    sortMode = SortMode.numerically;

    widget.album.tracks.sort((a, b) {
      return a.index?.compareTo(b.index ?? 0) ?? 0;
    });

    super.initState();
  }

  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RpIconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icons.arrow_back,
          ),
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
          const HorizontalSpacer(),
          const FavouriteButton(),
          const HorizontalSpacer(),
          const RpIconButton(
            onPressed: null,
            icon: Icons.more_vert,
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
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            // const VerticalSpacer(),
                            Text(widget.album.artist),
                            const VerticalSpacer(),
                            Text(
                              'Year: ${widget.album.year}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            // const VerticalSpacer(),
                            Text(
                              '${RetipL10n.of(context).tracks}: ${widget.album.tracks.length}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            // const VerticalSpacer(),
                            Text(
                              '${RetipL10n.of(context).duration}: ${duration.text}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            // const VerticalSpacer(),
                            const Divider(),
                            Wrap(
                              children: [
                                RpIconButton.filledTonal(
                                  onPressed: () {
                                    PlayAudio.call(
                                      widget.album.tracks,
                                      shuffle: true,
                                    );
                                  },
                                  icon: Icons.shuffle,
                                ),
                                const HorizontalSpacer(),
                                RpIconButton.filled(
                                  onPressed: () {
                                    PlayAudio.call(
                                      widget.album.tracks,
                                      shuffle: false,
                                    );
                                  },
                                  icon: Icons.play_arrow,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: Sizer.x2),
                  const TracksHeader(),
                ],
              ),
            );
          }

          final track = widget.album.tracks[index - 1];

          final isFavourite = IsInFavourites.call(track);

          return TrackTile(
            showArtwork: false,
            track: track,
            onTap: () => PlayAudio.call(
              widget.album.tracks,
              index: index - 1,
            ),
            quickAction: FavouriteButton(
              isFavourite: isFavourite,
              onPressed: () {
                if (isFavourite) {
                  RemoveFromFavourites.call(track);
                } else {
                  AddToFavourites.call(track);
                }

                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }
}
