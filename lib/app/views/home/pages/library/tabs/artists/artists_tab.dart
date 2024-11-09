import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/get_all_artists.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/views/home/pages/artist/artist_page.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class ArtistsTab extends StatelessWidget {
  final String search;

  const ArtistsTab({
    this.search = '',
    super.key,
  });

  static Future<List<ArtistEntity>> future = GetAllArtists.call();

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
              .where((e) => e.name.toLowerCase().contains(search.toLowerCase()))
              .toList();

          if (data.isEmpty) {
            return Center(
              child: Text(RetipL10n.of(context).noArtists),
            );
          }

          data.removeWhere((artist) => artist.albums.isEmpty);

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            // padding: const EdgeInsets.all(Sizer.x0_5),
            padding: const EdgeInsets.symmetric(
                vertical: Sizer.x1 + Sizer.x0_5, horizontal: Sizer.x0_5),

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final artist = data[index];

              return Padding(
                padding: const EdgeInsets.all(Sizer.x0_5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(Sizer.x1),
                  ),
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(Sizer.x1),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ArtistPage(artist: artist);
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: CircleAvatar(
                              radius: double.infinity,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surfaceBright,
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  radius: double.infinity,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  backgroundImage: artist.artwork != null
                                      ? Image.memory(
                                          artist.artwork!,
                                          fit: BoxFit.cover,
                                        ).image
                                      : null,
                                  child: artist.artwork == null
                                      ? LayoutBuilder(
                                          builder: (context, constraints) {
                                          return SizedBox.square(
                                              dimension: constraints
                                                  .biggest.shortestSide,
                                              child: Center(
                                                  child: Icon(
                                                Icons.person,
                                                size: constraints
                                                        .biggest.shortestSide /
                                                    2,
                                              )));
                                        })
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Sizer.x0_5,
                          ),
                          Text(
                            artist.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                    ),
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
