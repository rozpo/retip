import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/favourites/get_all_favourites.dart';
import 'package:retip/app/services/cases/play_audio.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/views/dev/dev_menu.dart';
import 'package:retip/app/views/home/pages/album/album_page.dart';
import 'package:retip/app/views/home/pages/artist/artist_page.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/rp_app_bar.dart';
import 'package:retip/app/widgets/rp_divider.dart';
import 'package:retip/app/widgets/rp_list_tile.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/app/widgets/track_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RpAppBar(
        leading: const Icon(Icons.queue_music_outlined),
        title: Text(RetipL10n.of(context).retip),
        actions: [
          if (kReleaseMode == false) ...[
            const HorizontalSpacer(),
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DevMenu(),
                ),
              ),
              icon: const Icon(Icons.developer_board),
            ),
          ]
        ],
      ),
      body: FutureBuilder(
        future: Future.wait([
          GetAllFavourites.call<ArtistEntity>('ArtistModel'),
          GetAllFavourites.call<AlbumEntity>('AlbumModel'),
          GetAllFavourites.call<TrackEntity>('TrackModel'),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final data = snapshot.requireData;

          if (data.isEmpty) {
            return Center(
              child: Text(RetipL10n.of(context).noTracks),
            );
          }

          final artists = snapshot.requireData[0] as List<ArtistEntity>;
          final albums = snapshot.requireData[1] as List<AlbumEntity>;
          final tracks = snapshot.requireData[2] as List<TrackEntity>;

          return ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              RpDivider(text: RetipL10n.of(context).artists),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: artists.length,
                itemBuilder: (context, index) {
                  final artist = artists[index];
                  final theme = Theme.of(context);

                  return RpListTile(
                    leading: Container(
                      width: Sizer.x5,
                      height: Sizer.x5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizer.max),
                        color: theme.colorScheme.surfaceBright,
                      ),
                      child: ArtworkWidget(
                        style: ArtworkStyle.circle,
                        bytes: artist.artwork,
                        borderWidth: 0,
                      ),
                    ),
                    title: Text(artist.name),
                    subtitle: Text(
                        '${artist.albums.length} ${RetipL10n.of(context).albums.toLowerCase()}'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ArtistPage(
                              artist: artist,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              RpDivider(text: RetipL10n.of(context).albums),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final album = albums[index];
                  final theme = Theme.of(context);

                  return RpListTile(
                    leading: Container(
                      width: Sizer.x5,
                      height: Sizer.x5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizer.x0_5),
                        color: theme.colorScheme.surfaceBright,
                      ),
                      child: ArtworkWidget(
                        bytes: album.artwork,
                        borderWidth: 0,
                      ),
                    ),
                    title: Text(album.title),
                    subtitle: Text(album.artist),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AlbumPage(album: album);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              RpDivider(text: RetipL10n.of(context).tracks),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  final track = tracks[index];

                  return TrackTile(
                    onTap: () => PlayAudio.call(tracks, index: index),
                    track: track,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
