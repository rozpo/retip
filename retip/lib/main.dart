import 'package:flutter/material.dart';
import 'package:retip/app/retip_app.dart';
import 'package:retip/core/theme/retip_theme.dart';

void main() {
  final theme = RetipTheme();

  final app = RetipApp(theme: theme);

  runApp(app);
}
