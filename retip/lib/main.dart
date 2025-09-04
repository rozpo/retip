import 'package:flutter/material.dart';
import 'package:retip/app/retip_app.dart';
import 'package:retip/core/logger/retip_logger.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/theme/retip_theme.dart';

void main() {
  final logger = RetipLogger();

  logger.debug('App initialization');

  logger.debug('LOCALE=${const String.fromEnvironment('LOCALE')}');
  logger.debug('MODE=${const String.fromEnvironment('MODE')}');

  final router = RetipRouter();
  final theme = RetipTheme();

  final app = RetipApp(router: router, theme: theme);

  runApp(app);

  logger.info('App started');
}
