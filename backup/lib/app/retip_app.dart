import 'package:flutter/material.dart';

import '../core/l10n/retip_l10n.dart';
import '../core/router/retip_router.dart';
import '../core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  final RetipRouter router;
  final RetipTheme theme;

  const RetipApp({
    required this.router,
    required this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: RetipL10n.localizationsDelegates,
      supportedLocales: RetipL10n.supportedLocales,
      themeMode: ThemeMode.dark,
      darkTheme: theme.dark,
      routerConfig: router,
      theme: theme.light,
    );
  }
}
