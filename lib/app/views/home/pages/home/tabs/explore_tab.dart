import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/favourites/get_all_favourites.dart';
import 'package:retip/app/services/cases/play_audio.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/entities/playlist_entity.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/views/album/album_view.dart';
import 'package:retip/app/views/artist/artist_view.dart';
import 'package:retip/app/views/playlist/playlist_view.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/rp_divider.dart';
import 'package:retip/app/widgets/rp_text.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/app/widgets/track_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  var artistsFuture = GetAllFavourites.call('ArtistModel');
  var albumsFuture = GetAllFavourites.call('AlbumModel');
  var tracksFuture = GetAllFavourites.call('TrackModel');
  var playlistsFuture = GetAllFavourites.call('PlaylistEntity');

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return FutureBuilder(
      future: Future.wait([
        artistsFuture,
        albumsFuture,
        tracksFuture,
        playlistsFuture,
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
        final tracks = snapshot.requireData[2] as List<TrackEntity>;
        final playlists = snapshot.requireData[3] as List<PlaylistEntity>;

        final size = MediaQuery.of(context).size.width;

        if (artists.isEmpty &&
            albums.isEmpty &&
            tracks.isEmpty &&
            playlists.isEmpty) {
          return Center(
            child: Text(l10n.noFavYet),
          );
        }

        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: Sizer.x1, bottom: Sizer.x2),
          shrinkWrap: true,
          children: [
            if (artists.isNotEmpty) ...[
              const VerticalSpacer(),
              RpDivider(
                text: '${l10n.liked} ${l10n.artists.toLowerCase()}',
              ),
              SizedBox(
                height: size / 2 + Sizer.x1 * 2,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Sizer.x1),
                  scrollDirection: Axis.horizontal,
                  itemCount: artists.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox.square(dimension: Sizer.x1);
                  },
                  itemBuilder: (context, index) {
                    final artist = artists[index];

                    return GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ArtistView(artist: artist);
                            },
                          ),
                        );

                        artistsFuture = GetAllFavourites.call('ArtistModel');
                        setState(() {});
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
            ],
            if (albums.isNotEmpty) ...[
              const VerticalSpacer(),
              RpDivider(
                text: '${l10n.liked} ${l10n.albums.toLowerCase()}',
              ),
              SizedBox(
                height: size / 3 + Sizer.x1 * 2,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Sizer.x1),
                  scrollDirection: Axis.horizontal,
                  itemCount: albums.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox.square(dimension: Sizer.x1);
                  },
                  itemBuilder: (context, index) {
                    final album = albums[index];

                    return GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return AlbumView(album: album);
                            },
                          ),
                        );

                        albumsFuture = GetAllFavourites.call('AlbumModel');
                        setState(() {});
                      },
                      child: ArtworkWidget(
                        borderWidth: 2,
                        bytes: album.artwork,
                      ),
                    );
                  },
                ),
              ),
            ],
            if (tracks.isNotEmpty) ...[
              const VerticalSpacer(),
              RpDivider(
                text: '${l10n.liked} ${l10n.tracks.toLowerCase()}',
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                // padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
                scrollDirection: Axis.vertical,
                itemCount: tracks.length,
                separatorBuilder: (context, index) {
                  return const SizedBox.square(dimension: Sizer.x1);
                },
                itemBuilder: (context, index) {
                  final track = tracks[index];

                  return TrackTile(
                    track: track,
                    onTap: () {
                      PlayAudio.call(tracks, index: index);
                    },
                    refresh: () {
                      tracksFuture = GetAllFavourites.call('TrackModel');
                      setState(() {});
                    },
                  );
                },
              ),
            ],
            if (playlists.isNotEmpty) ...[
              const VerticalSpacer(),
              RpDivider(
                text: '${l10n.liked} ${l10n.playlists.toLowerCase()}',
              ),
              SizedBox(
                height: size / 3 + Sizer.x1 * 2,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Sizer.x1),
                  scrollDirection: Axis.horizontal,
                  itemCount: playlists.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox.square(dimension: Sizer.x1);
                  },
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];

                    return GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return PlaylistView(playlist: playlist);
                            },
                          ),
                        );

                        playlistsFuture =
                            GetAllFavourites.call('PlaylistEntity');
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ArtworkWidget(
                              borderWidth: 2,
                              bytes: playlist.artwork,
                            ),
                          ),
                          const SizedBox(height: Sizer.x0_5),
                          RpText(
                            playlist.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
