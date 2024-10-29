import 'package:flutter/material.dart';
import 'package:retip/core/utils/sizer.dart';

class OptionListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;

  const OptionListTile({
    required this.text,
    required this.icon,
    required this.onTap,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
      leading: IconButton.filledTonal(
        style: Theme.of(context).iconButtonTheme.style,
        icon: Icon(icon),
        onPressed: null,
      ),
      title: Text(text),
      onTap: onTap,
    );
  }
}
