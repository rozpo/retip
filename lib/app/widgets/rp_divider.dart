import 'package:flutter/material.dart';
import 'package:retip/core/utils/sizer.dart';

class RpDivider extends StatelessWidget {
  final String? text;

  const RpDivider({
    this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (text != null)
          Padding(
            padding: const EdgeInsets.only(left: Sizer.x1),
            child: Text(text!),
          ),
        const Expanded(
          child: Divider(
            indent: Sizer.x1,
            endIndent: Sizer.x1,
            height: Sizer.x1,
          ),
        ),
      ],
    );
  }
}
