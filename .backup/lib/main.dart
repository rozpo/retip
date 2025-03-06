import 'package:flutter/material.dart';

import 'app/retip_app.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';

void main() {
  final router = RetipRouter();
  final theme = RetipTheme();

  final app = RetipApp(
    router: router,
    theme: theme,
  );

  runApp(app);
}
