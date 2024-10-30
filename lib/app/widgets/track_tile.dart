import 'package:flutter/material.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/core/utils/sizer.dart';

class TrackTile extends StatelessWidget {
  final TrackEntity track;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onMore;

  const TrackTile({
    required this.track,
    this.onTap,
    this.onLongPress,
    this.onMore,
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
        child: Center(
          child: Text(
            track.index.toString().padLeft(2, '0'),
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      trailing: IconButton(
        style: theme.iconButtonTheme.style,
        icon: const Icon(Icons.more_vert),
        onPressed: onMore,
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
