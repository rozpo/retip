import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/services/cases/favourites/add_to_favourites.dart';
import 'package:retip/app/services/cases/favourites/is_in_favourites.dart';
import 'package:retip/app/services/cases/favourites/remove_from_favourites.dart';
import 'package:retip/app/services/cases/play_audio.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/views/album/album_view.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/buttons/favourite_button.dart';
import 'package:retip/app/widgets/buttons/play_button.dart';
import 'package:retip/app/widgets/buttons/rp_back_button.dart';
import 'package:retip/app/widgets/buttons/shuffle_button.dart';
import 'package:retip/app/widgets/more/more_icon.dart';
import 'package:retip/app/widgets/player_widget.dart';
import 'package:retip/app/widgets/rp_app_bar.dart';
import 'package:retip/app/widgets/rp_text.dart';
import 'package:retip/app/widgets/sort_button.dart';
import 'package:retip/app/widgets/spacer.dart' hide Spacer;
import 'package:retip/app/widgets/tiles/add_to_fav_tile.dart';
import 'package:retip/app/widgets/tiles/remove_from_fav_tile.dart';
import 'package:retip/app/widgets/track_tile.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ArtistView extends StatefulWidget {
  final ArtistEntity artist;

  const ArtistView({
    required this.artist,
    super.key,
  });

  @override
  State<ArtistView> createState() => _ArtistViewState();
}

class _ArtistViewState extends State<ArtistView> {
  final RetipAudio player = GetIt.I.get();

  SortMode sortMode = SortMode.numerically;

  final tracks = <TrackEntity>[];

  Duration duration = Duration.zero;

  GlobalKey nameKey = GlobalKey();

  String name = '';

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
    final isInFavourites = IsInFavourites.call(widget.artist);

    return Scaffold(
      appBar: RpAppBar(
        title: Text(name),
        leading: const RpBackButton(),
        actions: [
          const HorizontalSpacer(),
          FavouriteButton(
            isFavourite: isInFavourites,
            onPressed: () {
              if (isInFavourites) {
                RemoveFromFavourites.call(widget.artist);
              } else {
                AddToFavourites.call(widget.artist);
              }

              setState(() {});
            },
          ),
          const HorizontalSpacer(),
          MoreIcon.vertical(
            title: widget.artist.name,
            image: widget.artist.artwork,
            tiles: [
              isInFavourites
                  ? RemoveFromFavTile(
                      widget.artist,
                      onTap: () => setState(() {}),
                    )
                  : AddToFavTile(
                      widget.artist,
                      onTap: () => setState(() {}),
                    ),
            ],
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
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Center(
                      child: SizedBox.square(
                        dimension: constraints.maxWidth / 2,
                        child: ArtworkWidget(
                          bytes: widget.artist.artwork,
                          style: ArtworkStyle.circle,
                        ),
                      ),
                    );
                  }),
                ),
                const VerticalSpacer(),
                VisibilityDetector(
                  key: nameKey,
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.9) {
                      name = '';
                    } else {
                      name = widget.artist.name;
                    }

                    if (context.mounted) {
                      setState(() {});
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RpText(
                        widget.artist.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: RpText(
                    '${RetipL10n.of(context).albumsCount(widget.artist.albums.length)} - ${RetipL10n.of(context).tracksCount(tracks.length)}',
                    textAlign: TextAlign.center,
                  ),
                ),
                const VerticalSpacer(),
                Row(
                  children: [
                    const HorizontalSpacer(),
                    Expanded(
                      child: ShuffleButton(
                        onPressed: () => PlayAudio.call(
                          tracks,
                          shuffle: true,
                        ),
                      ),
                    ),
                    const HorizontalSpacer(),
                    Expanded(
                      child: PlayButton(
                        onPressed: () => PlayAudio.call(
                          tracks,
                          shuffle: false,
                        ),
                      ),
                    ),
                    const HorizontalSpacer(),
                  ],
                ),
                const VerticalSpacer(),
                const VerticalSpacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                  child: Row(
                    children: [
                      const Icon(Icons.album),
                      const HorizontalSpacer(),
                      Text(
                        RetipL10n.of(context).albumsCount(
                          widget.artist.albums.length,
                        ),
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
                                return AlbumView(album: album);
                              },
                            ),
                          );

                          setState(() {});
                        },
                        child: SizedBox.square(
                          child: ArtworkWidget(
                            bytes: album.artwork,
                            borderWidth: 2,
                          ),
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
                      RpText(
                        RetipL10n.of(context).tracksCount(tracks.length),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          final track = tracks[index - 1];
          final isFavourite = IsInFavourites.call(track);

          return TrackTile(
            refresh: () => setState(() {}),
            goToArtist: false,
            showArtwork: true,
            track: track,
            onTap: () => PlayAudio.call(
              tracks,
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
