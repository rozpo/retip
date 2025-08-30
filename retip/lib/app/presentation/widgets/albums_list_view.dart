import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/blocs/albums/albums_bloc.dart';

class AlbumsListView extends StatelessWidget {
  final AlbumsBloc albumsBloc;

  const AlbumsListView({required this.albumsBloc, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsBloc, AlbumsState>(
      bloc: albumsBloc,
      builder: (context, state) {
        if (state.albums.isEmpty) {
          return const Center(child: Text('No albums found'));
        }

        return ListView.builder(
          itemCount: state.albums.length,
          itemBuilder: (context, index) {
            final album = state.albums[index];
            return ListTile(
              title: Text(album.title),
              subtitle: Text(album.artist),
            );
          },
        );
      },
    );
  }
}
