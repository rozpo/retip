import 'package:flutter/material.dart';
import 'package:retip/app/data/repositories/on_audio_query_album_repository.dart';

class AlbumsTab extends StatelessWidget {
  const AlbumsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: OnAudioQueryAlbumRepository().getAll(),
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

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final album = data[index];

              return ListTile(
                leading:
                    album.artwork != null ? Image.memory(album.artwork!) : null,
                title: Text(album.title),
                subtitle: Text(album.artist),
              );
            },
          );
        },
      ),
    );
  }
}
