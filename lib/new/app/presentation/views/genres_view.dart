import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/genre_entity.dart';
import '../../domain/usecases/genre_usecase.dart';
import 'tracks_view.dart';

class GenresView extends StatelessWidget {
  const GenresView({super.key});

  @override
  Widget build(BuildContext context) {
    final stream = context.read<GenreUsecase>().allStream();

    return StreamBuilder<List<GenreEntity>>(
      stream: stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Genres (${snapshot.data?.length ?? 0})'),
          ),
          body: ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final genre = snapshot.data![index];

              return ListTile(
                title: Text(genre.name),
                subtitle: Text('Tracks: ${genre.tracks.length}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TracksView(genreId: genre.id);
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
