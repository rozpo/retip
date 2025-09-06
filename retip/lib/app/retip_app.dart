import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/l10n/retip_l10n.dart';
import '../core/logger/retip_logger.dart';
import '../core/router/retip_router.dart';
import '../core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  final RetipLogger logger;
  final RetipRouter router;
  final RetipTheme theme;

  final Locale? locale;

  const RetipApp({
    required this.logger,
    required this.router,
    required this.theme,
    this.locale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: logger)],
      child: MaterialApp.router(
        localizationsDelegates: RetipL10n.localizationsDelegates,
        supportedLocales: RetipL10n.supportedLocales,
        themeMode: ThemeMode.system,
        darkTheme: theme.dark,
        routerConfig: router,
        theme: theme.light,
        locale: locale,
      ),
    );
  }
}
