import 'package:flutter/material.dart';
import '../atoms/single_line_text.dart';

class RpSnackbar extends SnackBar {
  final String message;

  RpSnackbar(
    BuildContext context, {
    required this.message,
    super.key,
  }) : super(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          duration: const Duration(seconds: 1),
          content: SingleLineText(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        );
}
