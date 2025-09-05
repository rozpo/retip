import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  final RetipRouter router;
  final RetipTheme theme;

  final Locale? locale;

  const RetipApp({
    required this.router,
    required this.theme,
    this.locale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: RetipL10n.localizationsDelegates,
      supportedLocales: RetipL10n.supportedLocales,
      themeMode: ThemeMode.system,
      darkTheme: theme.dark,
      routerConfig: router,
      theme: theme.light,
      locale: locale,
    );
  }
}
