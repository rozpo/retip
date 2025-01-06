import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/domain/cases/favourites/get_all_favourites.dart';
import 'package:retip/app/domain/cases/get_all_artists.dart';
import 'package:retip/app/domain/entities/artist_entity.dart';
import 'package:retip/app/presentation/pages/artist/artist_view.dart';
import 'package:retip/app/presentation/views/settings/cubit/settings_cubit.dart';
import 'package:retip/app/presentation/widgets/artwork_widget.dart';
import 'package:retip/app/presentation/widgets/rp_text.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';
import 'package:retip/core/extensions/string_extension.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class ArtistsTab extends StatefulWidget {
  final List<ArtistEntity> artists;

  const ArtistsTab({
    this.artists = const [],
    super.key,
  });

  @override
  State<ArtistsTab> createState() => _ArtistsTabState();
}

class _ArtistsTabState extends State<ArtistsTab> {
  static Future<List<ArtistEntity>> future = GetAllArtists.call();

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
              widget.artists.isNotEmpty ? widget.artists : snapshot.requireData;

          if (data.isEmpty) {
            return Center(
              child: Text(RetipL10n.of(context).noArtists),
            );
          }

          data.removeWhere((artist) => artist.albums.isEmpty);

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
              final artist = data[index];
              int tracksCount = 0;

              for (final album in artist.albums) {
                tracksCount += album.tracks.length;
              }

              return GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ArtistView(artist: artist);
                      },
                    ),
                  );

                  if (widget.artists.isNotEmpty) {
                    final data = await GetAllFavourites.call<ArtistEntity>(
                        'ArtistModel');

                    if (data.isEmpty && context.mounted) {
                      Navigator.of(context).pop();
                      return;
                    }

                    if (data.length != widget.artists.length) {
                      widget.artists.clear();
                      widget.artists.addAll(data);
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
                        bytes: artist.artwork,
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
                              artist.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            RpText(
                              '${RetipL10n.of(context).albumsCount(artist.albums.length)} - ${RetipL10n.of(context).tracksCount(tracksCount)}',
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
