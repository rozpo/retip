import 'package:flutter/material.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/core/utils/sizer.dart';

class RpDivider extends StatelessWidget {
  final String? text;
  final VoidCallback? showAll;

  const RpDivider({
    this.showAll,
    this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
          Padding(
            padding: const EdgeInsets.only(right: Sizer.x1),
            child: RpIconButton(
              icon: Icons.arrow_forward,
              onPressed: showAll,
            ),
          )
        ],
      ],
    );
  }
}
