import 'package:flutter/material.dart';

import '../atoms/short_text_atom.dart';

class TrackTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onMore;

  const TrackTile({
    required this.title,
    this.subtitle,
    this.onMore,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: const Icon(Icons.music_note),
      ),
      title: ShortTextAtom(title),
      subtitle: subtitle != null ? ShortTextAtom(subtitle!) : null,
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: onMore,
      ),
      onLongPress: () {},
    );
  }
}
