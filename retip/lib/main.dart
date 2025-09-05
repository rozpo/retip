import 'package:flutter/material.dart';
import 'package:retip/app/retip_app.dart';
import 'package:retip/core/logger/retip_logger.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/theme/retip_theme.dart';

void main() {
  final logger = RetipLogger();

  logger.debug('App initialization');

  const locale = String.fromEnvironment('LOCALE');
  const mode = String.fromEnvironment('MODE');

  logger.debug('LOCALE=$locale');
  logger.debug('MODE=$mode');

  final router = RetipRouter();
  final theme = RetipTheme();

  final app = RetipApp(
    locale: locale.isNotEmpty ? Locale(locale.toLowerCase()) : null,
    router: router,
    theme: theme,
  );

  runApp(app);

  logger.info('App started');
}
