import 'package:flutter/material.dart';
import 'package:retip/app/data/repositories/on_audio_query_artist_repository.dart';
import 'package:retip/app/views/home/pages/artist/artist_page.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class ArtistsTab extends StatelessWidget {
  const ArtistsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: OnAudioQueryArtistRepository().getAll(),
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
              child: Text(RetipL10n.of(context).noArtists),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final artist = data[index];

              return ListTile(
                leading: artist.artwork != null
                    ? Image.memory(artist.artwork!)
                    : null,
                title: Text(artist.name),
                subtitle: Text(artist.name),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ArtistPage(artist: artist);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
