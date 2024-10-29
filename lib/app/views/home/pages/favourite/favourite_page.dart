import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/services/cases/get_all_tracks.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/views/dev/dev_menu.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/app/views/search/search_view.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  static Future<List<TrackEntity>> future = GetAllTracks.call();

  bool isSearching = false;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? SearchBar(
                focusNode: focusNode,
                autoFocus: false,
                onChanged: (value) {
                  setState(() {});
                },
                hintText: '${RetipL10n.of(context).search}...',
                controller: controller,
                leading: const Icon(Icons.search),
                trailing: [
                  IconButton(
                    onPressed: () {
                      isSearching = false;
                      controller.text = '';
                      focusNode.unfocus();
                      setState(() {});
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              )
            : Text(RetipL10n.of(context).favourite),
        actions: isSearching
            ? null
            : [
                IconButton(
                  onPressed: () {
                    isSearching = true;
                    focusNode.requestFocus();
                    setState(() {});
                  },
                  icon: const Icon(Icons.search),
                ),
                if (kReleaseMode == false) ...[
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SearchView(),
                      ),
                    ),
                    icon: const Icon(Icons.saved_search),
                  ),
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
        future: future,
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

          final prefs = GetIt.I.get<SharedPreferences>();
          final favouriteTracks = prefs.getStringList('favourite_tracks') ?? [];

          final listOfFavouriteTracks = data.where((track) {
            return favouriteTracks.contains(track.id.toString());
          }).toList();

          final displayFavouriteTracks = listOfFavouriteTracks
              .where((e) =>
                  e.title.toLowerCase().contains(controller.text.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: displayFavouriteTracks.length,
            itemBuilder: (context, index) {
              final track = displayFavouriteTracks[index];

              return ListTile(
                leading: ArtworkWidget(bytes: track.artwork),
                title: Text(track.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(track.album),
                    Text(track.artist),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () async {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title:
                            Text(RetipL10n.of(context).alertRemoveFromFavTitle),
                        content:
                            Text(RetipL10n.of(context).alertRemoveFromFavMsg),
                        actions: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(RetipL10n.of(context).cancel),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);

                              favouriteTracks.remove(track.id.toString());

                              await prefs.setStringList(
                                  'favourite_tracks', favouriteTracks);

                              setState(() {});
                            },
                            child: Text(RetipL10n.of(context).remove),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
                onTap: () async {
                  final absoluteIndex = listOfFavouriteTracks.indexOf(track);
                  final audio = GetIt.instance.get<RetipAudio>();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlayerView(
                        player: audio,
                      ),
                    ),
                  );

                  await audio.playlistAddAll(listOfFavouriteTracks);
                  await audio.seekToIndex(absoluteIndex);
                  await audio.play();
                },
              );
            },
          );
        },
      ),
    );
  }
}
