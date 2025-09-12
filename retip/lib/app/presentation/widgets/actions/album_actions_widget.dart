import 'package:flutter/material.dart';
import 'package:retip/app/domain/enitities/album_entity.dart';
import 'package:retip/app/presentation/mixins/show_modal_bottom_sheet_mixin.dart';
import 'package:retip/app/presentation/widgets/tiles/goto_album_list_tile_widget.dart';
import 'package:retip/app/presentation/widgets/tiles/goto_artist_list_tile_widget.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';

class AlbumActionsWidget extends StatelessWidget
    with ShowModalBottomSheetMixin {
  final AlbumEntity album;

  const AlbumActionsWidget(this.album, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AlbumListTileWidget.none(album),
        // Divider(),
        // ListTile(
        //   title: SingleLineTextWidget('Play next'),
        //   leading: LeadingListTileCardWidget(Icons.playlist_play),
        // ),
        // AddToQueueListTileWidget(album),
        // ListTile(
        //   title: SingleLineTextWidget('Add to playlist'),
        //   leading: LeadingListTileCardWidget(Icons.playlist_add),
        // ),
        Divider(),
        GotoArtistListTileWidget(album.artistId),
        GotoAlbumListTileWidget(album.albumId),
      ],
    );
  }
}
