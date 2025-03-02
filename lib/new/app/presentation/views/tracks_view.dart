import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/track_entity.dart';
import '../../domain/usecases/track_usecase.dart';
import '../widgets/molecules/list_tile_molecule.dart';
import '../widgets/track_options.dart';

class TracksView extends StatefulWidget {
  final int? artistId;
  final int? albumId;
  final int? genreId;

  const TracksView({
    this.artistId,
    this.albumId,
    this.genreId,
    super.key,
  });

  @override
  State<TracksView> createState() => _TracksViewState();
}

class _TracksViewState extends State<TracksView> {
  late Stream<List<TrackEntity>> _stream;

  @override
  void initState() {
    super.initState();

    if (widget.artistId != null) {
      _stream = context.read<TrackUsecase>().byArtistStream(widget.artistId!);
    } else if (widget.albumId != null) {
      _stream = context.read<TrackUsecase>().byAlbumStream(widget.albumId!);
    } else if (widget.genreId != null) {
      _stream = context.read<TrackUsecase>().byGenreStream(widget.genreId!);
    } else {
      _stream = context.read<TrackUsecase>().allStream();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TrackEntity>>(
      stream: _stream,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            final track = snapshot.data![index];

            return ListTileMolecule(
              onMore: () => TrackOptions(track).show(context),
              subtitle: track.artist?.name,
              icon: Icons.music_note,
              title: track.title,
            );
            // onMore: () {
            // },
            // trailing: IconButton(
            //   onPressed: () {
            //     context.read<TrackUsecase>().toggleFavorite(track.id);
            //   },
            //   icon: Icon(
            //     track.isFavorite ? Icons.favorite : Icons.favorite_border,
            //   ),
            // ),
          },
        );
      },
    );
  }
}
