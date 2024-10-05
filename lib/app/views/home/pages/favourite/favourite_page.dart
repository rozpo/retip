import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/data/repositories/on_audio_query_track_repository.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/views/dev/dev_menu.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  static Future<List<TrackEntity>> future =
      OnAudioQueryTrackRepository().getAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RetipL10n.of(context).favourite),
        actions: [
          if (kReleaseMode == false) ...[
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

          return ListView.builder(
            itemCount: listOfFavouriteTracks.length,
            itemBuilder: (context, index) {
              final track = listOfFavouriteTracks[index];

              return ListTile(
                leading:
                    track.artwork != null ? Image.memory(track.artwork!) : null,
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
                    favouriteTracks.remove(track.id.toString());

                    await prefs.setStringList(
                        'favourite_tracks', favouriteTracks);

                    setState(() {});
                  },
                  icon: const Icon(Icons.delete),
                ),
                onTap: () async {
                  final audio = GetIt.instance.get<RetipAudio>();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlayerView(
                        player: audio,
                      ),
                    ),
                  );

                  await audio.playlistAddAll(listOfFavouriteTracks);
                  await audio.stop();
                  await audio.seekToIndex(index);
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
