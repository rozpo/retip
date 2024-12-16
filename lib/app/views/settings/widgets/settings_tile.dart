import 'package:flutter/material.dart';
import 'package:retip/app/widgets/rp_icon.dart';
import 'package:retip/app/widgets/rp_list_tile.dart';
import 'package:retip/app/widgets/rp_text.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const SettingsTile({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RpListTile(
      title: RpText(title),
      subtitle: subtitle != null ? RpText(subtitle!) : null,
      onTap: onTap,
      leading: RpIcon(
        icon: icon,
      ),
    );
  }
}
