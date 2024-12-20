import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/playlist/get_all_playlists.dart';
import 'package:retip/app/services/entities/playlist_entity.dart';
import 'package:retip/app/views/playlist/playlist_view.dart';
import 'package:retip/app/widgets/playlist_artwork.dart';
import 'package:retip/app/widgets/rp_text.dart';
import 'package:retip/core/extensions/string_extension.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class PlaylistsTab extends StatefulWidget {
  const PlaylistsTab({super.key});

  @override
  State<PlaylistsTab> createState() => _PlaylistsTabState();
}

class _PlaylistsTabState extends State<PlaylistsTab> {
  static List<PlaylistEntity> playlists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        initialData: playlists,
        future: GetAllPlaylists.call(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              playlists.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          bool hasChanged = snapshot.requireData.length != playlists.length;

          if (hasChanged == false) {
            for (int i = 0; i < playlists.length; i++) {
              final oldPlaylist = playlists[i];
              final newPlaylist = snapshot.requireData[i];

              if (oldPlaylist.tracks.length != newPlaylist.tracks.length) {
                hasChanged = true;
                break;
              }
            }
          }

          final data = hasChanged ? snapshot.requireData : playlists;
          if (hasChanged) {
            playlists = snapshot.requireData;
          }

          if (data.isEmpty) {
            return Center(
              child: Text(RetipL10n.of(context).noPlaylists),
            );
          }
          const columns = 3;

          final textLineHeight = 'A'.height(
              Theme.of(context).textTheme.bodySmall!,
              MediaQuery.of(context).size.width / columns);
          final textLineHeight2 = 'A'.height(
              Theme.of(context).textTheme.bodyMedium!,
              MediaQuery.of(context).size.width / columns);

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                vertical: Sizer.x1 + Sizer.x0_5, horizontal: Sizer.x1),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: Sizer.x1,
              crossAxisSpacing: Sizer.x1,
              crossAxisCount: columns,
              mainAxisExtent: MediaQuery.of(context).size.width / columns +
                  textLineHeight +
                  textLineHeight2,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final playlist = data[index];

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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizer.x1),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
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
                            RpText(
                              playlist.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            RpText(
                              RetipL10n.of(context)
                                  .tracksCount(playlist.tracks.length),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
