import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/views/home/pages/album/album_page.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/player/player_widget.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArtistPage extends StatefulWidget {
  final ArtistEntity artist;

  const ArtistPage({
    required this.artist,
    super.key,
  });

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  @override
  Widget build(BuildContext context) {
    final tracks = <TrackEntity>[];

    for (final album in widget.artist.albums) {
      for (final track in album.tracks) {
        tracks.add(track);
      }
    }

    return Scaffold(
      bottomSheet: const PlayerWidget(),
      appBar: AppBar(
        title: Text(widget.artist.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('10 tracks * 11min'),
                IconButton.filledTonal(
                    onPressed: () async {
                      final audio = GetIt.instance.get<RetipAudio>();

                      await audio.playlistAddAll(tracks);
                      await audio.stop();
                      await audio.play();
                    },
                    icon: const Icon(Icons.play_arrow)),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 3,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.artist.albums.length,
                itemBuilder: (context, index) {
                  final album = widget.artist.albums[index];

                  return GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AlbumPage(album: album);
                          },
                        ),
                      );

                      setState(() {});
                    },
                    child: SizedBox.square(
                      dimension: MediaQuery.of(context).size.width / 3,
                      child: ArtworkWidget(bytes: album.artwork),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  final prefs = GetIt.I.get<SharedPreferences>();
                  final favouriteTracks =
                      prefs.getStringList('favourite_tracks') ?? [];

                  final track = tracks[index];
                  track.isFavourite =
                      favouriteTracks.contains(track.id.toString());

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: IconButton.filledTonal(
                      onPressed: null,
                      icon: Text(track.index.toString().padLeft(2, '0')),
                    ),
                    title: Text(track.title),
                    subtitle: Text(track.artist),
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
                        track.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
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

                      await audio.playlistAddAll(tracks);
                      await audio.stop();
                      await audio.seekToIndex(index);
                      await audio.play();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
