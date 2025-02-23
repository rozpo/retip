import 'package:flutter/material.dart';

import '../atoms/short_text_atom.dart';

class ListTileMolecule extends StatelessWidget {
  final String title;
  final String? subtitle;

  const ListTileMolecule({
    required this.title,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.music_note),
      subtitle: subtitle != null ? ShortTextAtom(subtitle!) : null,
      title: ShortTextAtom(title),
    );
  }
}
