import 'package:flutter/material.dart';

import '../atoms/text_widget.dart';

class ListTileWidget extends StatelessWidget {
  final String? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final String title;

  const ListTileWidget({
    required this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: subtitle != null ? TextWidget.short(subtitle!) : null,
      title: TextWidget.short(title),
      trailing: trailing,
      leading: leading != null
          ? SizedBox.square(dimension: 40, child: leading)
          : leading,
    );
  }
}
