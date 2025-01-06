import 'package:flutter/material.dart';
import 'package:retip/core/utils/sizer.dart';

class RpBackButton extends StatelessWidget {
  const RpBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.all(Sizer.x1),
      // padding: EdgeInsets.zero,
      padding: const EdgeInsets.only(
        top: Sizer.x1,
        bottom: Sizer.x1,
        left: Sizer.x1,
        right: Sizer.x1,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        style: Theme.of(context).iconButtonTheme.style?.copyWith(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
