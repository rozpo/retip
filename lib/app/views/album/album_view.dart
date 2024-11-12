import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/favourites/add_to_favourites.dart';
import 'package:retip/app/services/cases/favourites/is_in_favourites.dart';
import 'package:retip/app/services/cases/favourites/remove_from_favourites.dart';
import 'package:retip/app/services/cases/play_audio.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/buttons/favourite_button.dart';
import 'package:retip/app/widgets/buttons/play_button.dart';
import 'package:retip/app/widgets/buttons/rp_back_button.dart';
import 'package:retip/app/widgets/buttons/shuffle_button.dart';
import 'package:retip/app/widgets/more/more_icon.dart';
import 'package:retip/app/widgets/player_widget.dart';
import 'package:retip/app/widgets/rp_app_bar.dart';
import 'package:retip/app/widgets/spacer.dart' hide Spacer;
import 'package:retip/app/widgets/tiles/add_to_fav_tile.dart';
import 'package:retip/app/widgets/tiles/go_to_artist_tile.dart';
import 'package:retip/app/widgets/tiles/remove_from_fav_tile.dart';
import 'package:retip/app/widgets/track_tile.dart';
import 'package:retip/app/widgets/tracks_header.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AlbumView extends StatefulWidget {
  final AlbumEntity album;

  const AlbumView({
    required this.album,
    super.key,
  });

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  Duration duration = Duration.zero;

  @override
  void initState() {
    int seconds = 0;

    for (final track in widget.album.tracks) {
      seconds += track.duration.inSeconds;
    }

    duration = Duration(seconds: seconds);

    widget.album.tracks.sort((a, b) {
      return a.index?.compareTo(b.index ?? 0) ?? 0;
    });

    super.initState();
  }

  String title = '';

  ScrollController scrollController = ScrollController();

  GlobalKey titleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isInFavourites = IsInFavourites.call(widget.album);

    return Scaffold(
      appBar: RpAppBar(
        title: Text(title),
        leading: const RpBackButton(),
        actions: [
          const HorizontalSpacer(),
          FavouriteButton(
            isFavourite: isInFavourites,
            onPressed: () {
              if (isInFavourites) {
                RemoveFromFavourites.call(widget.album);
              } else {
                AddToFavourites.call(widget.album);
              }

              setState(() {});
            },
          ),
          const HorizontalSpacer(),
          MoreIcon.vertical(
            title: widget.album.title,
            subtitle:
                '${RetipL10n.of(context).album} - ${widget.album.artist}${widget.album.year != null ? ' - ${widget.album.year}' : ''}',
            image: widget.album.artwork,
            tiles: [
              isInFavourites
                  ? RemoveFromFavTile(
                      widget.album,
                      onTap: () => setState(() {}),
                    )
                  : AddToFavTile(
                      widget.album,
                      onTap: () => setState(() {}),
                    ),
              GoToArtistTile(widget.album.artistId!),
            ],
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox.square(
                    dimension: MediaQuery.of(context).size.width / 2,
                    child: ArtworkWidget(
                      bytes: widget.album.artwork,
                    ),
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Expanded(
                  //       child: ArtworkWidget(bytes: widget.album.artwork),
                  //     ),
                  //     const HorizontalSpacer(),
                  //     Expanded(
                  //       child: Wrap(
                  //         spacing: Sizer.x1,
                  //         runSpacing: Sizer.x1,
                  //         // mainAxisSize: MainAxisSize.min,
                  //         // crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           if (widget.album.year != null)
                  //             RpChip(text: widget.album.year!),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const VerticalSpacer(),
                  VisibilityDetector(
                    key: titleKey,
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.9) {
                        title = '';
                      } else {
                        title = widget.album.title;
                      }

                      if (context.mounted) {
                        setState(() {});
                      }
                    },
                    child: Text(
                      widget.album.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    widget.album.artist,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${RetipL10n.of(context).album}${widget.album.year != null ? ' - ${widget.album.year}' : ''}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: Sizer.x1),
                  Row(
                    children: [
                      Expanded(
                        child: ShuffleButton(
                          onPressed: () => PlayAudio.call(
                            widget.album.tracks,
                            shuffle: true,
                          ),
                        ),
                      ),
                      const HorizontalSpacer(),
                      Expanded(
                        child: PlayButton(
                          onPressed: () => PlayAudio.call(
                            widget.album.tracks,
                            shuffle: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacer(),
                  const VerticalSpacer(),
                  TracksHeader(value: widget.album.tracks.length),
                ],
              ),
            );
          }

          final track = widget.album.tracks[index - 1];

          final isFavourite = IsInFavourites.call(track);

          return TrackTile(
            refresh: () => setState(() {}),
            goToAlbum: false,
            showArtwork: false,
            track: track,
            onTap: () => PlayAudio.call(
              widget.album.tracks,
              index: index - 1,
            ),
            onMore: () {},
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
