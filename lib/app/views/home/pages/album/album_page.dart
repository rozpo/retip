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
import 'package:visibility_detector/visibility_detector.dart';

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

    // scrollController.addListener(() {
    //   final RenderObject? box = titleKey.currentContext?.findRenderObject();
    //   if (box != null) {
    //     title = '';
    //   } else {
    //     title = widget.album.title;
    //   }

    //   setState(() {});
    // });

    super.initState();
  }

  String title = '';

  bool isFavourite = false;

  ScrollController scrollController = ScrollController();

  GlobalKey titleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RpIconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icons.arrow_back,
          ),
        ),
        actions: [
          RpIconButton(
            onPressed: () {
              PlayAudio.call(
                widget.album.tracks,
                shuffle: true,
              );
            },
            icon: Icons.shuffle,
          ),
          const HorizontalSpacer(),
          RpIconButton(
            onPressed: () {
              PlayAudio.call(
                widget.album.tracks,
                shuffle: false,
              );
            },
            icon: Icons.play_arrow,
          ),
          const HorizontalSpacer(),
          RpIconButton(
            onPressed: () {},
            icon: Icons.more_vert,
          ),
          const HorizontalSpacer(),
        ],
      ),
      bottomNavigationBar: const PlayerWidget(),
      body: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
        physics: const BouncingScrollPhysics(),
        itemCount: widget.album.tracks.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ArtworkWidget(bytes: widget.album.artwork),
                      ),
                      const HorizontalSpacer(),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Year: ${widget.album.year}',
                                  // style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  '${RetipL10n.of(context).tracks}: ${widget.album.tracks.length}',
                                  // style: Theme.of(context).textTheme.bodySmall,
                                ),
                                // const VerticalSpacer(),
                                Text(
                                  '${RetipL10n.of(context).duration}: ${duration.text}',
                                  // style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  VerticalSpacer(),
                  VisibilityDetector(
                    key: titleKey,
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.9) {
                        title = '';
                      } else {
                        title = widget.album.title;
                      }

                      setState(() {});
                    },
                    child: Text(
                      widget.album.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // const VerticalSpacer(),
                  Text(widget.album.artist),
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
