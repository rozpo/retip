import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/favourites/add_to_favourites.dart';
import 'package:retip/app/services/cases/favourites/is_in_favourites.dart';
import 'package:retip/app/services/cases/favourites/remove_from_favourites.dart';
import 'package:retip/app/services/cases/get_artist.dart';
import 'package:retip/app/services/cases/play_audio.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/views/home/pages/artist/artist_page.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/buttons/favourite_button.dart';
import 'package:retip/app/widgets/buttons/play_button.dart';
import 'package:retip/app/widgets/buttons/shuffle_button.dart';
import 'package:retip/app/widgets/modal_bottom_sheet.dart';
import 'package:retip/app/widgets/option_list_tile.dart';
import 'package:retip/app/widgets/player_widget.dart';
import 'package:retip/app/widgets/rp_chip.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/app/widgets/spacer.dart' hide Spacer;
import 'package:retip/app/widgets/track_tile.dart';
import 'package:retip/app/widgets/tracks_header.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
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

  bool isFavourite = false;

  ScrollController scrollController = ScrollController();

  GlobalKey titleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: Padding(
          padding: const EdgeInsets.only(
              top: Sizer.x1, bottom: Sizer.x1, left: Sizer.x2, right: Sizer.x0),
          child: RpIconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icons.arrow_back,
          ),
        ),
        actions: [
          FavouriteButton(
            isFavourite: IsInFavourites.call(widget.album),
            onPressed: () {
              final isFavourte = IsInFavourites.call(widget.album);

              if (isFavourte) {
                RemoveFromFavourites.call(widget.album);
              } else {
                AddToFavourites.call(widget.album);
              }

              setState(() {});
            },
          ),
          const HorizontalSpacer(),
          RpIconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                context: context,
                builder: (context) {
                  return ModalBottomSheet(
                    options: [
                      if (widget.album.artistId != null)
                        OptionListTile(
                          text: RetipL10n.of(context).showAlbumArtist,
                          icon: Icons.person,
                          onTap: () async {
                            final artist =
                                await GetArtist.call(widget.album.artistId!);

                            if (context.mounted) {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ArtistPage(artist: artist);
                                  },
                                ),
                              );
                            }
                          },
                        ),
                    ],
                  );
                },
              );
            },
            icon: Icons.more_vert,
          ),
          const HorizontalSpacer(),
          const HorizontalSpacer(),
        ],
      ),
      bottomNavigationBar: const PlayerWidget(),
      body: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(Sizer.x2),
        physics: const BouncingScrollPhysics(),
        itemCount: widget.album.tracks.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ArtworkWidget(bytes: widget.album.artwork),
                    ),
                    const HorizontalSpacer(),
                    Expanded(
                      child: Wrap(
                        spacing: Sizer.x1,
                        runSpacing: Sizer.x1,
                        // mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.album.year != null)
                            RpChip(text: widget.album.year!),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(widget.album.artist),
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
                const SizedBox(height: Sizer.x2),
                const TracksHeader(),
              ],
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
