import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/playlist/get_all_playlists.dart';
import 'package:retip/app/services/entities/playlist_entity.dart';
import 'package:retip/app/views/playlist/playlist_view.dart';
import 'package:retip/app/widgets/playlist_artwork.dart';
import 'package:retip/app/widgets/rp_text.dart';
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

          final hasChanged = snapshot.requireData.length != playlists.length;
          final data = hasChanged ? snapshot.requireData : playlists;

          if (hasChanged) {
            playlists = snapshot.requireData;
          }

          if (data.isEmpty) {
            return Center(
              child: Text(RetipL10n.of(context).noPlaylists),
            );
          }

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: Sizer.x1 + Sizer.x0_5,
              horizontal: Sizer.x0_5,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final playlist = data[index];

              return Padding(
                padding: const EdgeInsets.all(Sizer.x0_5),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return PlaylistView(playlist: playlist);
                        },
                      ),
                    );

                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                          final dimension = constraints.maxHeight;

                          return SizedBox.square(
                            dimension: dimension,
                            child: PlaylistArtwork(images: playlist.artworks),
                          );
                        }),
                      ),
                      RpText(playlist.name),
                    ],
                  ),
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //     color: playlist.artwork == null
                  //         ? Theme.of(context).colorScheme.surfaceContainer
                  //         : null,
                  //     borderRadius: BorderRadius.circular(Sizer.x1),
                  //     border: Border.all(
                  //         width: 2,
                  //         color: Theme.of(context).colorScheme.surfaceBright),
                  //     image: playlist.artwork != null
                  //         ? DecorationImage(
                  //             fit: BoxFit.cover,
                  //             image: Image.memory(playlist.artwork!).image,
                  //           )
                  //         : null,
                  //   ),
                  //   child: Center(
                  //     child: Container(
                  //       color: Colors.black,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(Sizer.x1),
                  //         child: Text(
                  //           playlist.name,
                  //           textAlign: TextAlign.center,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
