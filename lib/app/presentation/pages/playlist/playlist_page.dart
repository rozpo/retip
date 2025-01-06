import 'package:flutter/material.dart';
import 'package:retip/app/domain/cases/favourites/add_to_favourites.dart';
import 'package:retip/app/domain/cases/favourites/is_in_favourites.dart';
import 'package:retip/app/domain/cases/favourites/remove_from_favourites.dart';
import 'package:retip/app/domain/cases/play_audio.dart';
import 'package:retip/app/domain/cases/playlist/read_playlist.dart';
import 'package:retip/app/domain/entities/playlist_entity.dart';
import 'package:retip/app/presentation/widgets/buttons/favourite_button.dart';
import 'package:retip/app/presentation/widgets/buttons/play_button.dart';
import 'package:retip/app/presentation/widgets/buttons/rp_back_button.dart';
import 'package:retip/app/presentation/widgets/buttons/shuffle_button.dart';
import 'package:retip/app/presentation/widgets/more/more_icon.dart';
import 'package:retip/app/presentation/widgets/playlist_artwork.dart';
import 'package:retip/app/presentation/widgets/rp_app_bar.dart';
import 'package:retip/app/presentation/widgets/spacer.dart' hide Spacer;
import 'package:retip/app/presentation/widgets/tiles/add_to_fav_tile.dart';
import 'package:retip/app/presentation/widgets/tiles/delete_playlist_tile.dart';
import 'package:retip/app/presentation/widgets/tiles/remove_from_fav_tile.dart';
import 'package:retip/app/presentation/widgets/tiles/remove_from_playlist_tile.dart';
import 'package:retip/app/presentation/widgets/tiles/rename_playlist_tile.dart';
import 'package:retip/app/presentation/widgets/track_tile.dart';
import 'package:retip/app/presentation/widgets/tracks_header.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PlaylistPage extends StatefulWidget {
  final PlaylistEntity playlist;

  const PlaylistPage({
    required this.playlist,
    super.key,
  });

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  late PlaylistEntity playlist;
  Duration duration = Duration.zero;

  @override
  void initState() {
    playlist = widget.playlist;
    int seconds = 0;

    for (final track in playlist.tracks) {
      seconds += track.duration.inSeconds;
    }

    duration = Duration(seconds: seconds);

    super.initState();
  }

  String title = '';

  ScrollController scrollController = ScrollController();

  GlobalKey titleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isInFavourites = IsInFavourites.call(playlist);

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
                RemoveFromFavourites.call(playlist);
              } else {
                AddToFavourites.call(playlist);
              }

              setState(() {});
            },
          ),
          const HorizontalSpacer(),
          MoreIcon.vertical(
            title: playlist.name,
            subtitle: RetipL10n.of(context).tracksCount(playlist.tracks.length),
            image: playlist.artwork,
            tiles: [
              isInFavourites
                  ? RemoveFromFavTile(
                      playlist,
                      onTap: () => setState(() {}),
                    )
                  : AddToFavTile(
                      playlist,
                      onTap: () => setState(() {}),
                    ),
              RenamePlaylistTile(
                playlist,
                onTap: () {
                  setState(() {});
                },
              ),
              DeletePlaylistTile(playlist),
            ],
          ),
          const HorizontalSpacer(),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
        physics: const BouncingScrollPhysics(),
        itemCount: playlist.tracks.length + 1,
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
                    child: PlaylistArtwork(images: playlist.artworks),
                  ),
                  const VerticalSpacer(),
                  VisibilityDetector(
                    key: titleKey,
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.9) {
                        title = '';
                      } else {
                        title = playlist.name;
                      }

                      if (context.mounted) {
                        setState(() {});
                      }
                    },
                    child: Text(
                      playlist.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                      '${RetipL10n.of(context).playlist} - ${RetipL10n.of(context).tracksCount(playlist.tracks.length)}'),
                  const SizedBox(height: Sizer.x1),
                  Row(
                    children: [
                      Expanded(
                        child: ShuffleButton(
                          onPressed: () => PlayAudio.call(
                            playlist.tracks,
                            shuffle: true,
                          ),
                        ),
                      ),
                      const HorizontalSpacer(),
                      Expanded(
                        child: PlayButton(
                          onPressed: () => PlayAudio.call(
                            playlist.tracks,
                            shuffle: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacer(),
                  const VerticalSpacer(),
                  TracksHeader(value: playlist.tracks.length),
                ],
              ),
            );
          }

          final track = playlist.tracks[index - 1];

          final isFavourite = IsInFavourites.call(track);

          return TrackTile(
            refresh: () async {
              final newPlaylist = await ReadPlaylist.call('pl_${playlist.id}');

              if (newPlaylist != null &&
                  newPlaylist.tracks.length != playlist.tracks.length) {
                playlist = newPlaylist;
                setState(() {});
              }
            },
            goToAlbum: true,
            showArtwork: true,
            track: track,
            onTap: () => PlayAudio.call(
              playlist.tracks,
              index: index - 1,
            ),
            onMore: () {},
            moreActions: [
              RemoveFromPlaylistTile(
                track: track,
                playlist: playlist,
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
