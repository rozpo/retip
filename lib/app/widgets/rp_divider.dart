import 'package:flutter/material.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class RpDivider extends StatelessWidget {
  final VoidCallback? showAll;
  final Widget? leading;
  final String? text;

  const RpDivider({
    this.showAll,
    this.leading,
    this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leading != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: Sizer.x1),
            child: leading!,
          ),
        ],
        if (text != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: Sizer.x1),
            child: Text(text!),
          ),
        ],
        const Expanded(
          child: Divider(
            indent: Sizer.x1,
            endIndent: Sizer.x1,
            height: Sizer.x1,
          ),
        ),
        if (showAll != null) ...[
          GestureDetector(
            onTap: showAll,
            child: Padding(
              padding: const EdgeInsets.only(right: Sizer.x1),
              child: Row(
                children: [
                  Text(
                    RetipL10n.of(context).showAll,
                  ),
                  RpIconButton(
                    icon: Icons.arrow_forward,
                    onPressed: showAll,
                  ),
                ],
              ),
            ),
          )
        ],
      ],
    );
  }
}
