import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../atoms/artwork_widget.dart';
import '../../../../core/utils/sizer.dart';

class OptionListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isActive;
  final Uint8List? artwork;
  final Widget? trailing;

  const OptionListTile({
    this.artwork,
    required this.title,
    this.subtitle,
    required this.icon,
    this.trailing,
    this.onTap,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
      leading: Container(
        width: Sizer.x5,
        height: Sizer.x5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizer.x0_5),
          color: Theme.of(context).colorScheme.surfaceBright,
        ),
        child: artwork != null
            ? ArtworkWidget(
                bytes: artwork,
                borderWidth: 0,
              )
            : Icon(icon),
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      onTap: onTap,
      trailing: trailing,
    );
  }
}
