import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class IntroAllowButtonWidget extends StatelessWidget {
  final void Function()? onPressed;

  const IntroAllowButtonWidget({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(RetipL10n.of(context).allow.toUpperCase()),
    );
  }
}
