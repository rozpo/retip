import 'package:flutter/material.dart';
import 'package:retip/app/domain/enitities/album_entity.dart';
import 'package:retip/app/presentation/widgets/actions/album_actions_widget.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';
import 'package:retip/core/router/retip_route.dart';

class AlbumListTileWidget extends StatelessWidget {
  final AlbumEntity album;
  final VoidCallback? onTap;
  final Widget? action;

  const AlbumListTileWidget(this.album, {this.onTap, this.action, super.key});

  factory AlbumListTileWidget.none(AlbumEntity album, {VoidCallback? onTap}) {
    return AlbumListTileWidget(action: SizedBox(), album, onTap: () {});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SingleLineTextWidget(album.title),
      subtitle: SingleLineTextWidget(album.artist),
      leading: Card(
        child: SizedBox.square(dimension: 40, child: Icon(Icons.album)),
      ),
      trailing:
          action ??
          IconButton(
            onPressed: () => AlbumActionsWidget(album).show(context),
            icon: Icon(Icons.more_vert),
          ),
      onTap:
          onTap ??
          () => RetipRoute.album.push(
            pathParameters: {'id': album.albumId.toString()},
            context,
          ),
    );
  }
}
