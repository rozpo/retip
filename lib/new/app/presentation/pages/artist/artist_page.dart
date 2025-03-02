import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/artist_entity.dart';
import '../../../domain/usecases/artist_usecase.dart';
import '../../views/tracks_view.dart';

class ArtistPage extends StatefulWidget {
  final int id;

  const ArtistPage({
    required this.id,
    super.key,
  });

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late final Stream<ArtistEntity?> _stream;

  @override
  void initState() {
    super.initState();
    _stream = context.read<ArtistUsecase>().byIdStream(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArtistEntity?>(
      stream: _stream,
      builder: (context, snapshot) {
        final artist = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text(artist?.name ?? ''),
          ),
          body: artist == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: artist.albums.length,
                        itemBuilder: (context, index) {
                          final album = artist.albums[index];
                          return ListTile(
                            title: Text(album.title),
                            subtitle: Text(album.artist?.name ?? ''),
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
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: artist.tracks.length,
                        itemBuilder: (context, index) {
                          final track = artist.tracks[index];
                          return ListTile(
                            title: Text(track.title),
                            subtitle: Text(track.album?.title ?? ''),
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
