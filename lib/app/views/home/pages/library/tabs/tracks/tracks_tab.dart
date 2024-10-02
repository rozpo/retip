import 'package:flutter/material.dart';
import 'package:retip/app/data/repositories/on_audio_query_track_repository.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class TracksTab extends StatelessWidget {
  const TracksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: OnAudioQueryTrackRepository().getAll(),
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

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final track = data[index];

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
              );
            },
          );
        },
      ),
    );
  }
}
