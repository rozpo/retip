import 'package:flutter/material.dart';

import '../atoms/text_widget.dart';

class ListTileWidget extends StatelessWidget {
  final VoidCallback? onActionTap;
  final IconData? actionIcon;
  final VoidCallback? onTap;
  final IconData tileIcon;
  final String? subtitle;
  final String title;

  const ListTileWidget({
    required this.tileIcon,
    required this.title,
    this.onActionTap,
    this.actionIcon,
    this.subtitle,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: subtitle != null ? TextWidget.short(subtitle!) : null,
      title: TextWidget.short(title),
      onTap: onTap,
      leading: Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        height: 40,
        width: 40,
        child: Icon(tileIcon),
      ),
      trailing: actionIcon != null
          ? IconButton(
              style: Theme.of(context).iconButtonTheme.style,
              icon: Icon(actionIcon),
              onPressed: onActionTap,
            )
          : null,
    );
  }
}
