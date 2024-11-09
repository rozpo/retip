import 'package:flutter/material.dart';
import 'package:retip/app/widgets/rp_icon.dart';
import 'package:retip/app/widgets/rp_list_tile.dart';

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
    return RpListTile(
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
