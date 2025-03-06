import 'package:flutter/material.dart';

import '../atoms/text_atom.dart';

class ListTileMolecule extends StatelessWidget {
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final String? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final String title;

  const ListTileMolecule({
    required this.title,
    this.onLongPress,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: subtitle != null ? TextAtom.short(subtitle!) : null,
      title: TextAtom.short(title),
      onLongPress: onLongPress,
      trailing: trailing,
      leading: leading,
      onTap: onTap,
    );
  }
}
