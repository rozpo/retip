import 'package:flutter/material.dart';
import 'package:retip/app/domain/entities/track_entity.dart';
import 'package:retip/app/presentation/widgets/atoms/artwork_widget.dart';
import 'package:retip/app/presentation/widgets/atoms/single_line_text.dart';
import 'package:retip/app/presentation/widgets/atoms/rp_icon_button.dart';
import 'package:retip/app/presentation/widgets/molecules/rp_list_tile.dart';
import 'package:retip/core/utils/sizer.dart';

class TracksListWidget extends StatelessWidget {
  final List<TrackEntity> tracks;
  final void Function(int index)? onTap;

  const TracksListWidget({
    required this.tracks,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(
        decelerationRate: ScrollDecelerationRate.normal,
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];

        return RpListTile(
          leading: SizedBox.square(
            dimension: Sizer.x5,
            child: ArtworkWidget(
              bytes: track.artwork,
              borderWidth: 1,
            ),
          ),
          title: SingleLineText(track.title),
          subtitle: SingleLineText(track.artist),
          onTap: () => onTap?.call(index),
          trailing: const RpIconButton(icon: Icons.more_vert),
        );
      },
    );
  }
}
