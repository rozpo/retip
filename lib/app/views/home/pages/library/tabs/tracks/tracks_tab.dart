import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/data/repositories/on_audio_query_track_repository.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TracksTab extends StatefulWidget {
  const TracksTab({super.key});

  @override
  State<TracksTab> createState() => _TracksTabState();
}

class _TracksTabState extends State<TracksTab> {
  static Future<List<TrackEntity>> future =
      OnAudioQueryTrackRepository().getAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final track = data[index];
              track.isFavourite = favouriteTracks.contains(track.id.toString());

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
                    if (track.isFavourite) {
                      favouriteTracks.remove(track.id.toString());
                    } else {
                      favouriteTracks.add(track.id.toString());
                    }

                    await prefs.setStringList(
                        'favourite_tracks', favouriteTracks);

                    setState(() {});
                  },
                  icon: Icon(
                    track.isFavourite ? Icons.favorite : Icons.favorite_border,
                  ),
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

                  await audio.playlistAddAll(data);
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
