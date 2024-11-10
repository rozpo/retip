import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/favourites/add_to_favourites.dart';
import 'package:retip/app/services/cases/favourites/is_in_favourites.dart';
import 'package:retip/app/services/cases/favourites/remove_from_favourites.dart';
import 'package:retip/app/services/cases/play_audio.dart';
import 'package:retip/app/services/entities/playlist_entity.dart';
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
import 'package:retip/app/widgets/tiles/delete_playlist_tile.dart';
import 'package:retip/app/widgets/tiles/remove_from_fav_tile.dart';
import 'package:retip/app/widgets/tiles/remove_from_playlist_tile.dart';
import 'package:retip/app/widgets/track_tile.dart';
import 'package:retip/app/widgets/tracks_header.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PlaylistView extends StatefulWidget {
  final PlaylistEntity playlist;

  const PlaylistView({
    required this.playlist,
    super.key,
  });

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  Duration duration = Duration.zero;

  @override
  void initState() {
    int seconds = 0;

    for (final track in widget.playlist.tracks) {
      seconds += track.duration.inSeconds;
    }

    duration = Duration(seconds: seconds);

    widget.playlist.tracks.sort((a, b) {
      return a.index?.compareTo(b.index ?? 0) ?? 0;
    });

    super.initState();
  }

  String title = '';

  ScrollController scrollController = ScrollController();

  GlobalKey titleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isInFavourites = IsInFavourites.call(widget.playlist);

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
                RemoveFromFavourites.call(widget.playlist);
              } else {
                AddToFavourites.call(widget.playlist);
              }

              setState(() {});
            },
          ),
          const HorizontalSpacer(),
          MoreIcon.vertical(
            title: widget.playlist.name,
            subtitle: RetipL10n.of(context)
                .tracksCount(widget.playlist.tracks.length),
            image: widget.playlist.artwork,
            tiles: [
              isInFavourites
                  ? RemoveFromFavTile(
                      widget.playlist,
                      onTap: () => setState(() {}),
                    )
                  : AddToFavTile(
                      widget.playlist,
                      onTap: () => setState(() {}),
                    ),
              DeletePlaylistTile(widget.playlist),
            ],
          ),
          const HorizontalSpacer(),
        ],
      ),
      bottomNavigationBar: const PlayerWidget(),
      body: ListView.builder(
        shrinkWrap: true,
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
        physics: const BouncingScrollPhysics(),
        itemCount: widget.playlist.tracks.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
              child: Column(
                // shrinkWrap: true,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox.square(
                    dimension: MediaQuery.of(context).size.width / 2,
                    child: ArtworkWidget(bytes: widget.playlist.artwork),
                  ),
                  const VerticalSpacer(),
                  VisibilityDetector(
                    key: titleKey,
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.9) {
                        title = '';
                      } else {
                        title = widget.playlist.name;
                      }

                      if (context.mounted) {
                        setState(() {});
                      }
                    },
                    child: Text(
                      widget.playlist.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(RetipL10n.of(context)
                      .tracksCount(widget.playlist.tracks.length)),
                  const SizedBox(height: Sizer.x1),
                  Row(
                    children: [
                      Expanded(
                        child: ShuffleButton(
                          onPressed: () => PlayAudio.call(
                            widget.playlist.tracks,
                            shuffle: true,
                          ),
                        ),
                      ),
                      const HorizontalSpacer(),
                      Expanded(
                        child: PlayButton(
                          onPressed: () => PlayAudio.call(
                            widget.playlist.tracks,
                            shuffle: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacer(),
                  const VerticalSpacer(),
                  TracksHeader(value: widget.playlist.tracks.length),
                ],
              ),
            );
          }

          final track = widget.playlist.tracks[index - 1];

          final isFavourite = IsInFavourites.call(track);

          return TrackTile(
            refresh: () => setState(() {}),
            goToAlbum: false,
            showArtwork: false,
            track: track,
            onTap: () => PlayAudio.call(
              widget.playlist.tracks,
              index: index - 1,
            ),
            onMore: () {},
            moreActions: [
              RemoveFromPlaylistTile(
                track: track,
                playlist: widget.playlist,
                onTap: () {
                  setState(() {});
                },
              )
            ],
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
