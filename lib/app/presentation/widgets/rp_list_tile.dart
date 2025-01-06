import 'package:flutter/material.dart';
import 'package:retip/core/utils/sizer.dart';

class RpListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Widget? subtitle;

  final VoidCallback? onTap;

  const RpListTile({
    this.leading,
    this.trailing,
    this.title,
    this.subtitle,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: Sizer.x1,
      minTileHeight: Sizer.x7,
      minVerticalPadding: Sizer.x1,
      contentPadding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
      leading: leading,
      trailing: trailing,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
    );
  }
}
