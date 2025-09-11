import 'package:flutter/material.dart';
import 'package:retip/app/domain/enitities/artist_entity.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';
import 'package:retip/core/router/retip_route.dart';

class ArtistListTileWidget extends StatelessWidget {
  final ArtistEntity artist;

  const ArtistListTileWidget(this.artist, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SingleLineTextWidget(artist.name),
      subtitle: SingleLineTextWidget(artist.name),
      leading: Card(
        child: SizedBox.square(dimension: 40, child: Icon(Icons.person)),
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      onTap: () => RetipRoute.artist.push(
        pathParameters: {'id': artist.artistId.toString()},
        context,
      ),
    );
  }
}
