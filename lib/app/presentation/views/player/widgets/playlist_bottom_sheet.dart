import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/data/providers/just_audio_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaylistBottomSheet extends StatefulWidget {
  final JustAudioProvider player;

  const PlaylistBottomSheet({
    required this.player,
    super.key,
  });

  @override
  State<PlaylistBottomSheet> createState() => _PlaylistBottomSheetState();
}

class _PlaylistBottomSheetState extends State<PlaylistBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: widget.player.tracks.length,
          itemBuilder: (context, index) {
            final prefs = GetIt.I.get<SharedPreferences>();
            final favouriteTracks =
                prefs.getStringList('favourite_tracks') ?? [];

            final track = widget.player.tracks[index];
            track.isFavourite = favouriteTracks.contains(track.id.toString());

            return ListTile(
              leading: Text(track.index.toString().padLeft(2, '0')),
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
                  track.isFavourite ? Icons.favorite : Icons.favorite_border,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                await widget.player.seekToIndex(index);
              },
            );
          }),
    );
  }
}
