import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class IntroAllowButtonWidget extends StatelessWidget {
  final void Function()? onPressed;

  const IntroAllowButtonWidget({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizer.x0_5)),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(Sizer.x1),
        child: Text(RetipL10n.of(context).allow.toUpperCase()),
      ),
    );
  }
}
