import 'package:flutter/material.dart';
import 'package:retip/app/domain/cases/favourites/is_in_favourites.dart';
import 'package:retip/app/domain/entities/track_entity.dart';
import 'package:retip/app/presentation/widgets/atoms/artwork_widget.dart';
import 'package:retip/app/presentation/widgets/atoms/more_icon.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/add_to_fav_tile.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/add_to_playlist_tile.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/file_details.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/go_to_album_tile.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/go_to_artist_tile.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/remove_from_fav_tile.dart';
import 'package:retip/core/utils/sizer.dart';

class TrackTile extends StatelessWidget {
  final TrackEntity track;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onMore;
  final Widget? quickAction;
  final bool showArtwork;
  final bool goToAlbum;
  final bool goToArtist;
  final VoidCallback? refresh;
  final List<Widget> moreActions;

  const TrackTile({
    required this.track,
    this.showArtwork = true,
    this.goToAlbum = true,
    this.goToArtist = true,
    this.onTap,
    this.onLongPress,
    this.onMore,
    this.quickAction,
    this.refresh,
    this.moreActions = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    int? index = track.index;

    while (index! > 1000) {
      index -= 1000;
    }

    return ListTile(
      onTap: onTap,
      leading: Container(
        width: Sizer.x5,
        height: Sizer.x5,
        decoration: BoxDecoration(
          image: showArtwork == false && track.artwork != null
              ? DecorationImage(
                  image: Image.memory(track.artwork!).image, opacity: 0.1)
              : null,
          borderRadius: BorderRadius.circular(Sizer.x0_5),
          color: theme.colorScheme.surfaceBright,
        ),
        child: showArtwork
            ? ArtworkWidget(
                bytes: track.artwork,
                borderWidth: 0,
              )
            : Center(
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // if (quickAction != null) ...[
          //   quickAction!,
          //   const HorizontalSpacer(),
          // ],
          MoreIcon.horizontal(
            title: track.title,
            subtitle: track.artist,
            image: track.artwork,
            tiles: [
              IsInFavourites.call(track)
                  ? RemoveFromFavTile(
                      track,
                      onTap: refresh,
                    )
                  : AddToFavTile(track, onTap: refresh),
              AddToPlaylistTile(track: track),
              ...moreActions,
              if (goToAlbum && track.albumId != null)
                GoToAlbumTile(
                  track.albumId!,
                  refresh: refresh,
                ),
              if (goToArtist && track.artistId != null)
                GoToArtistTile(
                  track.artistId!,
                  refresh: refresh,
                ),
              FileDetailsTile(track: track),
            ],
          ),
        ],
      ),
      title: Text(
        track.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        track.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
