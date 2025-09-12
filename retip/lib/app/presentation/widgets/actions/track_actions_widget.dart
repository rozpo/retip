import 'package:flutter/material.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/presentation/mixins/show_modal_bottom_sheet_mixin.dart';
import 'package:retip/app/presentation/widgets/cards/leading_list_tile_card_widget.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';

class TrackActionsWidget extends StatelessWidget
    with ShowModalBottomSheetMixin {
  final TrackEntity track;

  const TrackActionsWidget(this.track, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TrackListTileWidget.favourite(track),
        Divider(),
        ListTile(
          title: SingleLineTextWidget('Play next'),
          leading: LeadingListTileCardWidget(Icons.playlist_play),
        ),
        ListTile(
          title: SingleLineTextWidget('Add to queue'),
          leading: LeadingListTileCardWidget(Icons.queue_music),
        ),
        ListTile(
          title: SingleLineTextWidget('Add to playlist'),
          leading: LeadingListTileCardWidget(Icons.playlist_add),
        ),
        Divider(),
        ListTile(
          title: SingleLineTextWidget('Go to Artist'),
          leading: LeadingListTileCardWidget(Icons.person),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          title: SingleLineTextWidget('Go to Album'),
          leading: LeadingListTileCardWidget(Icons.album),
          trailing: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
