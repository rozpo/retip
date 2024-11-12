import 'dart:math';

import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/get_all_albums.dart';
import 'package:retip/app/services/cases/get_all_artists.dart';
import 'package:retip/app/services/cases/playlist/get_all_playlists.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/entities/playlist_entity.dart';
import 'package:retip/app/views/album/album_view.dart';
import 'package:retip/app/views/artist/artist_view.dart';
import 'package:retip/app/views/playlist/playlist_view.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/rp_text.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          GetAllArtists.call(),
          GetAllAlbums.call(),
          GetAllPlaylists.call(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError || snapshot.hasData == false) {
            return Center(
              child: Text(RetipL10n.of(context).somethingGotWrong),
            );
          }

          final artists = snapshot.requireData[0] as List<ArtistEntity>;
          final albums = snapshot.requireData[1] as List<AlbumEntity>;
          final playlists = snapshot.requireData[2] as List<PlaylistEntity>;
          final size = MediaQuery.of(context).size.width;

          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: Sizer.x1),
                child: RpText(
                  RetipL10n.of(context).artists,
                ),
              ),
              SizedBox(
                height: size / 2 + Sizer.x1 * 2,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Sizer.x1),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (context, index) {
                    return const SizedBox.square(dimension: Sizer.x1);
                  },
                  itemBuilder: (context, index) {
                    final artist = artists[Random().nextInt(artists.length)];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ArtistView(artist: artist);
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ArtworkWidget(
                              borderWidth: 2,
                              bytes: artist.artwork,
                              style: ArtworkStyle.circle,
                            ),
                          ),
                          const SizedBox(height: Sizer.x0_5),
                          RpText(
                            artist.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: Sizer.x1),
                child: RpText(
                  RetipL10n.of(context).albums,
                ),
              ),
              SizedBox(
                height: size / 3 + Sizer.x1 * 2,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Sizer.x1),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (context, index) {
                    return const SizedBox.square(dimension: Sizer.x1);
                  },
                  itemBuilder: (context, index) {
                    final album = albums[Random().nextInt(albums.length)];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return AlbumView(album: album);
                            },
                          ),
                        );
                      },
                      child: ArtworkWidget(
                        borderWidth: 2,
                        bytes: album.artwork,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: Sizer.x1),
                child: RpText(
                  RetipL10n.of(context).playlists,
                ),
              ),
              SizedBox(
                height: size / 4 + Sizer.x1 * 2,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Sizer.x1),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (context, index) {
                    return const SizedBox.square(dimension: Sizer.x1);
                  },
                  itemBuilder: (context, index) {
                    final playlist =
                        playlists[Random().nextInt(playlists.length)];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return PlaylistView(playlist: playlist);
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: size / 4,
                        // height: size / 4,
                        decoration: BoxDecoration(
                          color: playlist.artwork == null
                              ? Theme.of(context).colorScheme.surfaceContainer
                              : null,
                          borderRadius: BorderRadius.circular(Sizer.x1),
                          border: Border.all(
                              width: 2,
                              color:
                                  Theme.of(context).colorScheme.surfaceBright),
                          image: playlist.artwork != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.memory(playlist.artwork!).image,
                                )
                              : null,
                        ),
                        child: Center(
                          child: Container(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(Sizer.x1),
                              child: Text(
                                playlist.name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
