import 'package:flutter/material.dart';
import '../atoms/rp_icon.dart';

class MoreTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const MoreTile({
    required this.icon,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        text,
      ),
      onTap: onTap,
      leading: RpIcon(icon: icon),
    );
  }
}
