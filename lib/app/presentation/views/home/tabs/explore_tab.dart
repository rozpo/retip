import 'package:flutter/material.dart';
import 'package:retip/app/domain/cases/favourites/get_all_favourites.dart';
import 'package:retip/app/domain/cases/play_audio.dart';
import 'package:retip/app/domain/entities/abstract_entity.dart';
import 'package:retip/app/domain/entities/album_entity.dart';
import 'package:retip/app/domain/entities/artist_entity.dart';
import 'package:retip/app/domain/entities/playlist_entity.dart';
import 'package:retip/app/domain/entities/track_entity.dart';
import 'package:retip/app/presentation/pages/album/album_page.dart';
import 'package:retip/app/presentation/pages/artist/artist_page.dart';
import 'package:retip/app/presentation/pages/favourites/favourites_page.dart';
import 'package:retip/app/presentation/pages/playlist/playlist_page.dart';
import 'package:retip/app/presentation/views/albums/albums_view.dart';
import 'package:retip/app/presentation/views/artists/artists_view.dart';
import 'package:retip/app/presentation/views/playlists/playlists_view.dart';
import 'package:retip/app/presentation/widgets/atoms/artwork_widget.dart';
import 'package:retip/app/presentation/widgets/atoms/single_line_text.dart';
import 'package:retip/app/presentation/widgets/atoms/playlist_artwork.dart';
import 'package:retip/app/presentation/widgets/organisms/rp_app_bar.dart';
import 'package:retip/app/presentation/widgets/molecules/rp_divider.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/track_tile.dart';
import 'package:retip/core/extensions/string_extension.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

import '../../../widgets/atoms/spinner_widget.dart';

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

  static List<List<AbstractEntity>> initialData = const [];

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return FutureBuilder(
      initialData: initialData,
      future: Future.wait([
        artistsFuture,
        albumsFuture,
        tracksFuture,
        playlistsFuture,
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done &&
            initialData.isEmpty) {
          return const Center(
            child: SpinnerWidget(),
          );
        }

        if (snapshot.hasError || snapshot.hasData == false) {
          return Center(
            child: Text(RetipL10n.of(context).somethingGotWrong),
          );
        }

        bool hasChanged = initialData.length != snapshot.requireData.length;

        if (hasChanged == false) {
          for (int i = 0; i < snapshot.requireData.length; i++) {
            if (initialData[i].length != snapshot.requireData[i].length) {
              hasChanged = true;
              break;
            }
          }
        }

        // Check if playlist has changed
        if (hasChanged == false) {
          final playlists = List<PlaylistEntity>.from(snapshot.requireData[3]);
          for (int i = 0; i < playlists.length; i++) {
            final oldPlaylist = List<PlaylistEntity>.from(initialData[3])[i];
            final newPlaylist = playlists[i];

            if (oldPlaylist.tracks.length != newPlaylist.tracks.length) {
              hasChanged = true;
              break;
            }
          }
        }

        if (hasChanged) {
          initialData = snapshot.requireData;
        }

        final artists = List<ArtistEntity>.from(
            hasChanged ? snapshot.requireData[0] : initialData[0]);
        final albums = List<AlbumEntity>.from(
            hasChanged ? snapshot.requireData[1] : initialData[1]);
        final tracks = List<TrackEntity>.from(
            hasChanged ? snapshot.requireData[2] : initialData[2]);
        final playlists = List<PlaylistEntity>.from(
            hasChanged ? snapshot.requireData[3] : initialData[3]);

        final size = MediaQuery.of(context).size.width;

        if (artists.isEmpty &&
            albums.isEmpty &&
            tracks.isEmpty &&
            playlists.isEmpty) {
          return Center(
            child: Text(l10n.noFavYet),
          );
        }

        final textLineHeight = 'A'.height(
            Theme.of(context).textTheme.bodySmall!,
            MediaQuery.of(context).size.width);
        final textLineHeight2 = 'A'.height(
            Theme.of(context).textTheme.bodyMedium!,
            MediaQuery.of(context).size.width);

        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: Sizer.x1, bottom: Sizer.x2),
          shrinkWrap: true,
          children: [
            if (artists.isNotEmpty) ...[
              RpDivider(
                leading: const Icon(
                  Icons.person,
                  size: Sizer.x2,
                ),
                text: '${l10n.liked} ${l10n.artists.toLowerCase()}',
                showAll: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: RpAppBar(
                          title: Text(
                              '${l10n.liked} ${l10n.artists.toLowerCase()}'),
                        ),
                        body: ArtistsView(artists: artists),
                      );
                    }),
                  );

                  artistsFuture = GetAllFavourites.call('ArtistModel');
                  setState(() {});
                },
              ),
              SizedBox(
                height: size / 2 + textLineHeight2 + textLineHeight + Sizer.x3,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Sizer.x1),
                  scrollDirection: Axis.horizontal,
                  itemCount: artists.length.clamp(1, 10),
                  separatorBuilder: (context, index) {
                    return const SizedBox.square(dimension: Sizer.x1);
                  },
                  itemBuilder: (context, index) {
                    final artist = artists[index];
                    int tracksCount = 0;

                    for (final album in artist.albums) {
                      tracksCount += album.tracks.length;
                    }

                    return GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ArtistPage(artist: artist);
                            },
                          ),
                        );

                        artistsFuture = GetAllFavourites.call('ArtistModel');
                        setState(() {});
                      },
                      child: Container(
                        width: size / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizer.x1),
                          color: Theme.of(context).colorScheme.surfaceContainer,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ArtworkWidget(
                              bytes: artist.artwork,
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
                                    artist.name,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  SingleLineText(
                                    '${RetipL10n.of(context).albumsCount(artist.albums.length)} - ${RetipL10n.of(context).tracksCount(tracksCount)}',
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
            ],
            if (albums.isNotEmpty) ...[
              RpDivider(
                leading: const Icon(
                  Icons.album,
                  size: Sizer.x2,
                ),
                text: '${l10n.liked} ${l10n.albums.toLowerCase()}',
                showAll: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: RpAppBar(
                          title: Text(
                              '${l10n.liked} ${l10n.albums.toLowerCase()}'),
                        ),
                        body: AlbumsView(albums: albums),
                      );
                    }),
                  );

                  albumsFuture = GetAllFavourites.call('AlbumModel');
                  setState(() {});
                },
              ),
              SizedBox(
                height: size / 3 + textLineHeight2 + textLineHeight + Sizer.x3,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Sizer.x1),
                  scrollDirection: Axis.horizontal,
                  itemCount: albums.length.clamp(1, 10),
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
                              return AlbumPage(album: album);
                            },
                          ),
                        );

                        albumsFuture = GetAllFavourites.call('AlbumModel');
                        setState(() {});
                      },
                      child: Container(
                        width: size / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizer.x1),
                          color: Theme.of(context).colorScheme.surfaceContainer,
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
            ],
            if (playlists.isNotEmpty) ...[
              RpDivider(
                leading: const Icon(
                  Icons.queue_music,
                  size: Sizer.x2,
                ),
                text: '${l10n.liked} ${l10n.playlists.toLowerCase()}',
                showAll: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: RpAppBar(
                          title: Text(
                              '${l10n.liked} ${l10n.playlists.toLowerCase()}'),
                        ),
                        body: PlaylistsView(playlists: playlists),
                      );
                    }),
                  );

                  playlistsFuture = GetAllFavourites.call('PlaylistEntity');
                  setState(() {});
                },
              ),
              SizedBox(
                height: size / 4 + textLineHeight2 + textLineHeight + Sizer.x3,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Sizer.x1),
                  scrollDirection: Axis.horizontal,
                  itemCount: playlists.length.clamp(1, 10),
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
                              return PlaylistPage(playlist: playlist);
                            },
                          ),
                        );

                        playlistsFuture =
                            GetAllFavourites.call('PlaylistEntity');
                        setState(() {});
                      },
                      child: Container(
                        width: size / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizer.x1),
                          color: Theme.of(context).colorScheme.surfaceContainer,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                final dimension = constraints.maxHeight;

                                return SizedBox.square(
                                  dimension: dimension,
                                  child: PlaylistArtwork(
                                    images: playlist.artworks,
                                  ),
                                );
                              }),
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
                                    playlist.name,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  SingleLineText(
                                    RetipL10n.of(context)
                                        .tracksCount(playlist.tracks.length),
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
            ],
            if (tracks.isNotEmpty) ...[
              RpDivider(
                leading: const Icon(
                  Icons.music_note,
                  size: Sizer.x2,
                ),
                text: '${l10n.liked} ${l10n.tracks.toLowerCase()}',
                showAll: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return const FavouritesPage();
                    }),
                  );

                  tracksFuture = GetAllFavourites.call('TrackModel');
                  setState(() {});
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: tracks.length.clamp(1, 10),
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
          ],
        );
      },
    );
  }
}
