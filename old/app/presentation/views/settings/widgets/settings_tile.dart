import 'package:flutter/material.dart';
import '../../../widgets/atoms/rp_icon.dart';
import '../../../widgets/atoms/single_line_text.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsTile({
    required this.title,
    required this.icon,
    this.subtitle,
    this.trailing,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SingleLineText(title),
      subtitle: subtitle != null ? SingleLineText(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
      leading: RpIcon(
        icon: icon,
      ),
    );
  }
}
