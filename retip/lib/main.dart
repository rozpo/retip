import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/retip_app.dart';
import 'package:retip/core/logger/retip_logger.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/theme/retip_theme.dart';

void main() {
  // Logger initialization
  final logger = RetipLogger();

  // Startup config read
  const locale = String.fromEnvironment('LOCALE');
  const mode = String.fromEnvironment('MODE');

  logger.debug('App initialization');
  logger.debug('LOCALE=$locale');
  logger.debug('MODE=$mode');

  // Setup app based on config
  Bloc.observer = logger.blocObserver;

  // Dependency injection
  final router = RetipRouter(logger);
  final theme = RetipTheme();

  // Assemble final app
  final app = RetipApp(
    locale: locale.isNotEmpty ? Locale(locale.toLowerCase()) : null,
    logger: logger,
    router: router,
    theme: theme,
  );

  runApp(app);

  logger.info('App started');
}
