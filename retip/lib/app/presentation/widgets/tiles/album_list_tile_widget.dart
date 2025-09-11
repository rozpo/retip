import 'package:flutter/material.dart';
import 'package:retip/app/domain/enitities/album_entity.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';
import 'package:retip/core/router/retip_route.dart';

class AlbumListTileWidget extends StatelessWidget {
  final AlbumEntity album;

  const AlbumListTileWidget(this.album, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SingleLineTextWidget(album.title),
      subtitle: SingleLineTextWidget(album.artist),
      leading: Card(
        child: SizedBox.square(dimension: 40, child: Icon(Icons.album)),
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      onTap: () => RetipRoute.album.push(
        pathParameters: {'id': album.albumId.toString()},
        context,
      ),
    );
  }
}
