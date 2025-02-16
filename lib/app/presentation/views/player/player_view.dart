import 'package:flutter/material.dart';
import '../../../data/providers/just_audio_provider.dart';
import '../../../domain/cases/favourites/add_to_favourites.dart';
import '../../../domain/cases/favourites/is_in_favourites.dart';
import '../../../domain/cases/favourites/remove_from_favourites.dart';
import '../../../domain/entities/track_entity.dart';
import '../../widgets/atoms/more_icon.dart';
import '../../widgets/atoms/rp_icon_button.dart';
import '../../widgets/atoms/spacer.dart';
import '../../widgets/molecules/rp_divider.dart';
import '../../widgets/molecules/tiles/add_to_fav_tile.dart';
import '../../widgets/molecules/tiles/add_to_playlist_tile.dart';
import '../../widgets/molecules/tiles/go_to_album_tile.dart';
import '../../widgets/molecules/tiles/go_to_artist_tile.dart';
import '../../widgets/molecules/tiles/remove_from_fav_tile.dart';
import '../../widgets/molecules/tiles/track_tile.dart';
import '../../../../core/l10n/retip_l10n.dart';
import '../../../../core/router/retip_router.dart';
import '../../../../core/utils/sizer.dart';

import 'widgets/audio_info_widget.dart';
import 'widgets/player_artwork_widget.dart';

class PlayerView extends StatefulWidget {
  final JustAudioProvider player;

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
    return StreamBuilder<int?>(
      stream: widget.player.currentIndexStream,
      builder: (context, snapshot) {
        currentIndex = snapshot.data;

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
              RpIconButton(
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
                icon: currentTrack != null && isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              const HorizontalSpacer(),
              RpIconButton(
                onPressed: () async {
                  await showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      context: RetipRouter.rootNavKey.currentContext ?? context,
                      builder: (context) {
                        return Column(
                          children: [
                            ListTile(
                              leading:
                                  const RpIconButton(icon: Icons.queue_music),
                              title: Text(RetipL10n.of(context).playlingQueue),
                              trailing: RpIconButton(
                                icon: Icons.close,
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            const RpDivider(),
                            Expanded(
                              child: ListView.builder(
                                itemCount: widget.player.tracks.length,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                    vertical: Sizer.x2),
                                itemBuilder: (context, index) {
                                  final track = widget.player.tracks[index];

                                  return TrackTile(
                                    track: track,
                                    onTap: () {
                                      Navigator.pop(context);

                                      widget.player.seekToIndex(index);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      });

                  setState(() {});
                },
                icon: Icons.queue_music,
              ),
              const HorizontalSpacer(),
              if (currentTrack != null) ...[
                MoreIcon.vertical(
                  title: currentTrack!.title,
                  subtitle: currentTrack!.artist,
                  image: currentTrack!.artwork,
                  tiles: [
                    isFavourite
                        ? RemoveFromFavTile(
                            currentTrack!,
                            onTap: () => setState(() {}),
                          )
                        : AddToFavTile(
                            currentTrack!,
                            onTap: () => setState(() {}),
                          ),
                    AddToPlaylistTile(track: currentTrack!),
                    GoToAlbumTile(currentTrack!.albumId!),
                    GoToArtistTile(currentTrack!.artistId!),
                  ],
                ),
                const HorizontalSpacer(),
              ]
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
      },
    );
  }
}
