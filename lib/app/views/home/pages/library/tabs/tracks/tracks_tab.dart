import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/services/cases/get_all_tracks.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/views/player/player_view.dart'
    hide PlayerArtworkWidget;
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TracksTab extends StatefulWidget {
  final String search;
  const TracksTab({this.search = '', super.key});

  @override
  State<TracksTab> createState() => _TracksTabState();
}

class _TracksTabState extends State<TracksTab> {
  static Future<List<TrackEntity>> future = GetAllTracks.call();

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

          final allData = snapshot.requireData;

          final data = snapshot.requireData
              .where((e) =>
                  e.title.toLowerCase().contains(widget.search.toLowerCase()))
              .toList();

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
                leading: ArtworkWidget(bytes: track.artwork),
                title: RetipUtils.getQueryText(
                  context,
                  track.title,
                  widget.search,
                ),
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
                  final albsoluteIndex = allData.indexOf(track);
                  final audio = GetIt.instance.get<RetipAudio>();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlayerView(
                        player: audio,
                      ),
                    ),
                  );

                  await audio.playlistAddAll(allData);
                  await audio.seekToIndex(albsoluteIndex);
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
