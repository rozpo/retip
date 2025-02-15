import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/new/core/theme/retip_theme.dart';

import '../core/l10n/retip_l10n.dart';
import '../core/router/retip_router.dart';

class RetipApp extends StatelessWidget {
  final RetipRouter _retipRouter;
  final RetipTheme _retipTheme;
  final RetipL10n _retipL10n;

  const RetipApp({
    required RetipRouter retipRouter,
    required RetipTheme retipTheme,
    required RetipL10n retipL10n,
    super.key,
  })  : _retipRouter = retipRouter,
        _retipTheme = retipTheme,
        _retipL10n = retipL10n;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _retipL10n),
      ],
      child: MaterialApp.router(
        localizationsDelegates: _retipL10n.localizationsDelegates,
        supportedLocales: _retipL10n.supportedLocales,
        themeMode: ThemeMode.system,
        darkTheme: _retipTheme.dark,
        routerConfig: _retipRouter,
        theme: _retipTheme.light,
      ),
    );
  }
}
