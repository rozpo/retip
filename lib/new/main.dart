import 'package:flutter/material.dart';

import 'app/retip_app.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';

void main() async {
  final retipRouter = RetipRouter();
  final retipTheme = RetipTheme();

  final retipApp = RetipApp(
    retipRouter: retipRouter,
    retipTheme: retipTheme,
  );

  runApp(retipApp);
}
