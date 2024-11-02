import 'package:flutter/material.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/widgets/artwork_widget.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/core/utils/sizer.dart';

class TrackTile extends StatelessWidget {
  final TrackEntity track;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onMore;
  final Widget? quickAction;
  final bool showArtwork;

  const TrackTile({
    required this.track,
    this.showArtwork = true,
    this.onTap,
    this.onLongPress,
    this.onMore,
    this.quickAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      contentPadding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
      leading: Container(
        width: Sizer.x5,
        height: Sizer.x5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizer.x0_5),
          color: theme.colorScheme.surfaceBright,
        ),
        child: showArtwork
            ? ArtworkWidget(
                bytes: track.artwork,
                borderWidth: 0,
              )
            : Center(
                child: Text(
                  track.index.toString().padLeft(2, '0'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (quickAction != null) ...[
            quickAction!,
            const HorizontalSpacer(),
          ],
          RpIconButton(
            icon: Icons.more_vert,
            onPressed: onMore,
          ),
        ],
      ),
      title: Text(
        track.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        track.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
