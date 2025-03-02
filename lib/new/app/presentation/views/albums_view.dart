import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/sizer.dart';
import '../../domain/entities/album_entity.dart';
import '../../domain/usecases/album_usecase.dart';
import '../pages/album/album_page.dart';
import '../widgets/molecules/list_tile_molecule.dart';

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
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: Sizer.small),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final album = snapshot.data![index];

              return ListTileMolecule(
                icon: Icons.album,
                title: album.title,
                subtitle: album.artist?.name,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AlbumPage(
                          title: album.title,
                          albumId: album.id,
                        );
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
