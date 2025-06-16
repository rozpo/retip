import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../data/providers/just_audio_provider.dart';
import '../../../domain/cases/favourites/add_to_favourites.dart';
import '../../../domain/cases/favourites/is_in_favourites.dart';
import '../../../domain/cases/favourites/remove_from_favourites.dart';
import '../../../domain/cases/play_audio.dart';
import '../../../domain/entities/artist_entity.dart';
import '../../../domain/entities/track_entity.dart';
import '../album/album_page.dart';
import '../../views/albums/albums_view.dart';
import '../../widgets/atoms/artwork_widget.dart';
import '../../widgets/atoms/favourite_button.dart';
import '../../widgets/atoms/more_icon.dart';
import '../../widgets/atoms/play_button.dart';
import '../../widgets/atoms/rp_back_button.dart';
import '../../widgets/atoms/rp_icon_button.dart';
import '../../widgets/atoms/shuffle_button.dart';
import '../../widgets/atoms/single_line_text.dart';
import '../../widgets/atoms/sort_button.dart';
import '../../widgets/atoms/spacer.dart' hide Spacer;
import '../../widgets/molecules/tiles/add_to_fav_tile.dart';
import '../../widgets/molecules/tiles/remove_from_fav_tile.dart';
import '../../widgets/molecules/tiles/track_tile.dart';
import '../../widgets/organisms/app_bar_widget.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/l10n/retip_l10n.dart';
import '../../../../core/utils/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ArtistPage extends StatefulWidget {
  final ArtistEntity artist;

  const ArtistPage({
    required this.artist,
    super.key,
  });

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  final JustAudioProvider player = GetIt.I.get();

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

    final textLineHeight = 'A'.height(Theme.of(context).textTheme.bodySmall!,
        MediaQuery.of(context).size.width);
    final textLineHeight2 = 'A'.height(Theme.of(context).textTheme.bodyMedium!,
        MediaQuery.of(context).size.width);

    return Scaffold(
      appBar: AppBarWidget(
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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
        physics: const BouncingScrollPhysics(),
        itemCount: tracks.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: MediaQuery.of(context).size.width / 2,
                  child: ArtworkWidget(
                    bytes: widget.artist.artwork,
                    style: ArtworkStyle.circle,
                  ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SingleLineText(
                      widget.artist.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SingleLineText(
                  '${RetipL10n.of(context).albumsCount(widget.artist.albums.length)} - ${RetipL10n.of(context).tracksCount(tracks.length)}',
                  textAlign: TextAlign.center,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                      RpIconButton(
                        icon: Icons.arrow_forward,
                        onPressed: () {
                          final l10n = RetipL10n.of(context);

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return Scaffold(
                                appBar: AppBarWidget(
                                  title: Text(
                                    '${widget.artist.name} - ${l10n.albumsCount(widget.artist.albums.length)}',
                                  ),
                                ),
                                body: AlbumsView(albums: widget.artist.albums),
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width / 3 +
                      textLineHeight2 +
                      textLineHeight +
                      Sizer.x3,
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
                                return AlbumPage(album: album);
                              },
                            ),
                          );

                          setState(() {});
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3, // tODO
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizer.x1),
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ArtworkWidget(
                                bytes: album.artwork,
                                borderWidth: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Sizer.x0_5,
                                  horizontal: Sizer.x1,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleLineText(
                                      album.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    SingleLineText(
                                      album.artist,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const VerticalSpacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                  child: Row(
                    children: [
                      const Icon(Icons.music_note),
                      const HorizontalSpacer(),
                      SingleLineText(
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
