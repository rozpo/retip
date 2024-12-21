import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/services/cases/get_all_albums.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/views/album/album_view.dart';
import 'package:retip/app/views/settings/cubit/settings_cubit.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/rp_text.dart';
import 'package:retip/core/extensions/string_extension.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class AlbumsTab extends StatelessWidget {
  final String search;

  const AlbumsTab({this.search = '', super.key});

  static Future<List<AlbumEntity>> future = GetAllAlbums.call();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future,
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

          final data = snapshot.requireData
              .where(
                  (e) => e.title.toLowerCase().contains(search.toLowerCase()))
              .toList();

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
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AlbumView(album: album);
                      },
                    ),
                  );
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
                            RpText(
                              album.title,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            RpText(
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
