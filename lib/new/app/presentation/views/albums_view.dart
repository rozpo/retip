import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/album_entity.dart';
import '../../domain/usecases/album_usecase.dart';
import 'tracks_view.dart';

class AlbumsView extends StatefulWidget {
  final int? artistId;

  const AlbumsView({
    this.artistId,
    super.key,
  });

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  late final Stream<List<AlbumEntity>> _stream;

  @override
  void initState() {
    super.initState();

    if (widget.artistId != null) {
      _stream = context.read<AlbumUsecase>().byArtistStream(widget.artistId!);
    } else {
      _stream = context.read<AlbumUsecase>().allStream();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AlbumEntity>>(
      stream: _stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Albums (${snapshot.data?.length ?? 0})'),
          ),
          body: ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final album = snapshot.data![index];

              return ListTile(
                title: Text(album.title),
                subtitle:
                    album.artist != null ? Text(album.artist!.name) : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TracksView(albumId: album.id);
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
