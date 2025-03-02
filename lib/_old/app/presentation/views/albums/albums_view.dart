import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/cases/favourites/get_all_favourites.dart';
import '../../../domain/cases/get_all_albums.dart';
import '../../../domain/entities/album_entity.dart';
import '../../pages/album/album_page.dart';
import '../settings/cubit/settings_cubit.dart';
import '../../widgets/atoms/artwork_widget.dart';
import '../../widgets/atoms/single_line_text.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/l10n/retip_l10n.dart';
import '../../../../core/utils/sizer.dart';

import '../../widgets/atoms/spinner_widget.dart';

class AlbumsView extends StatefulWidget {
  final List<AlbumEntity> albums;

  const AlbumsView({
    this.albums = const [],
    super.key,
  });

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  static Future<List<AlbumEntity>> future = GetAllAlbums.call();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: SpinnerWidget(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final data =
              widget.albums.isNotEmpty ? widget.albums : snapshot.requireData;

          if (data.isEmpty) {
            return Center(
              child: Text(RetipL10n.of(context).noAlbums),
            );
          }

          final columns = context.read<SettingsCubit>().state.gridViewColumns;

          final textLineHeight = 'A'.height(
              Theme.of(context).textTheme.bodySmall!,
              MediaQuery.of(context).size.width / columns);
          final textLineHeight2 = 'A'.height(
              Theme.of(context).textTheme.bodyMedium!,
              MediaQuery.of(context).size.width / columns);

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                vertical: Sizer.x1 + Sizer.x0_5, horizontal: Sizer.x1),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: Sizer.x1,
              crossAxisSpacing: Sizer.x1,
              crossAxisCount: columns,
              mainAxisExtent: MediaQuery.of(context).size.width / columns +
                  textLineHeight +
                  textLineHeight2,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final album = data[index];

              return GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AlbumPage(album: album);
                      },
                    ),
                  );

                  if (widget.albums.isNotEmpty) {
                    final data =
                        await GetAllFavourites.call<AlbumEntity>('AlbumModel');

                    if (data.isEmpty && context.mounted) {
                      Navigator.of(context).pop();
                      return;
                    }

                    if (data.length != widget.albums.length) {
                      widget.albums.clear();
                      widget.albums.addAll(data);
                      setState(() {});
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizer.x1),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ArtworkWidget(
                        bytes: album.artwork,
                        borderWidth: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizer.x0_5,
                          horizontal: Sizer.x1,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleLineText(
                              album.title,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SingleLineText(
                              album.artist,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
