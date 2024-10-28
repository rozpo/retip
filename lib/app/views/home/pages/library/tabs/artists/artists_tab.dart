import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/get_all_artists.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/views/home/pages/artist/artist_page.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/utils.dart';

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

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final artist = data[index];

              return ListTile(
                leading: artist.artwork != null
                    ? Image.memory(artist.artwork!)
                    : null,
                title: RetipUtils.getQueryText(context, artist.name, search),
                subtitle: Text(artist.name),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ArtistPage(artist: artist);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
