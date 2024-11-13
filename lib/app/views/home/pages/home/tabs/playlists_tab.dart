import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/playlist/get_all_playlists.dart';
import 'package:retip/app/views/playlist/playlist_view.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class PlaylistsTab extends StatefulWidget {
  const PlaylistsTab({super.key});

  @override
  State<PlaylistsTab> createState() => _PlaylistsTabState();
}

class _PlaylistsTabState extends State<PlaylistsTab> {
  // static Future<List<PlaylistEntity>> future = GetAllPlaylists.call();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RpIconButton.filled(
        icon: Icons.playlist_add,
        onPressed: () async {
          setState(() {});
        },
      ),
      body: FutureBuilder(
        future: GetAllPlaylists.call(),
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: playlist.artwork == null
                          ? Theme.of(context).colorScheme.surfaceContainer
                          : null,
                      borderRadius: BorderRadius.circular(Sizer.x1),
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.surfaceBright),
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
