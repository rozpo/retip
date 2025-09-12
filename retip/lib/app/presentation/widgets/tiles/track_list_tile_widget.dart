import 'package:flutter/material.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/presentation/widgets/actions/track_actions_widget.dart';
import 'package:retip/app/presentation/widgets/cards/leading_list_tile_card_widget.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';

class TrackListTileWidget extends StatelessWidget {
  final TrackEntity track;
  final VoidCallback? onTap;
  final Widget? action;

  const TrackListTileWidget(this.track, {this.onTap, this.action, super.key});

  factory TrackListTileWidget.none(TrackEntity track, {VoidCallback? onTap}) {
    return TrackListTileWidget(action: SizedBox(), track);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SingleLineTextWidget(track.title),
      subtitle: SingleLineTextWidget(track.artist),
      leading: LeadingListTileCardWidget(Icons.music_note),
      trailing:
          action ??
          IconButton(
            onPressed: () async =>
                await TrackActionsWidget(track).show(context),
            icon: Icon(Icons.more_vert),
          ),
      onTap: onTap,
    );
  }
}
