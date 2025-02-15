import 'package:flutter/material.dart';
import 'package:retip/new/core/theme/retip_theme.dart';

import '../core/router/retip_router.dart';

class RetipApp extends StatelessWidget {
  final RetipRouter _retipRouter;
  final RetipTheme _retipTheme;

  const RetipApp({
    required RetipRouter retipRouter,
    required RetipTheme retipTheme,
    super.key,
  })  : _retipRouter = retipRouter,
        _retipTheme = retipTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      darkTheme: _retipTheme.dark,
      routerConfig: _retipRouter,
      theme: _retipTheme.light,
    );
  }
}
