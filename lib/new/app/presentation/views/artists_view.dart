import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/artist_entity.dart';
import '../../domain/usecases/artist_usecase.dart';
import 'albums_view.dart';

class ArtistsView extends StatelessWidget {
  const ArtistsView({super.key});

  @override
  Widget build(BuildContext context) {
    final stream = context.read<ArtistUsecase>().allStream();

    return StreamBuilder<List<ArtistEntity>>(
      stream: stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Artists (${snapshot.data?.length ?? 0})'),
          ),
          body: ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final artist = snapshot.data![index];

              return ListTile(
                title: Text(artist.name),
                subtitle: Text('Albums: ${artist.albums.length}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AlbumsView(artistId: artist.id);
                      },
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
