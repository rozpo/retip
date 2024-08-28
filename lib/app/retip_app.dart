import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  const RetipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      showPerformanceOverlay: kProfileMode,
      themeMode: ThemeMode.system,
      theme: RetipTheme.light,
      darkTheme: RetipTheme.dark,
      highContrastTheme: RetipTheme.contrastLight,
      highContrastDarkTheme: RetipTheme.contrastDark,
      localizationsDelegates: RetipL10n.localizationsDelegates,
      supportedLocales: RetipL10n.supportedLocales,
      routerConfig: RetipRouter.router,
    );
  }
}
