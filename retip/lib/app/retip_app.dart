import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/router/retip_router.dart';
import '../core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  final RetipRouter router;
  final RetipTheme theme;

  const RetipApp({required this.router, required this.theme, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      showPerformanceOverlay: kProfileMode,
      themeMode: ThemeMode.system,
      darkTheme: theme.dark,
      routerConfig: router,
      theme: theme.light,
      title: 'Retip',
    );
  }
}
