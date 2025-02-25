import 'package:flutter/material.dart';

import '../atoms/icon_atom.dart';
import '../atoms/short_text_atom.dart';

class ListTileMolecule extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onMore;

  const ListTileMolecule({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onMore,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconAtom(icon),
      subtitle: subtitle != null ? ShortTextAtom(subtitle!) : null,
      title: ShortTextAtom(title),
      trailing: IconButton(
        style: Theme.of(context).iconButtonTheme.style,
        icon: const Icon(Icons.more_vert),
        onPressed: onMore,
      ),
    );
  }
}
