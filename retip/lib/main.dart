import 'package:flutter/material.dart';

import 'app/retip_app.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';

void main() {
  final theme = RetipTheme();
  final router = RetipRouter();

  final app = RetipApp(theme: theme, router: router);

  runApp(app);
}
