import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'app/presentation/cubits/dev/dev_cubit.dart';
import 'app/retip_app.dart';
import 'core/logger/retip_logger.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';
import 'core/utils/run_mode.dart';

final logger = RetipLogger();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = logger.blocObserver;

  final router = RetipRouter(observers: [logger.navigatorObserver]);
  final theme = RetipTheme();

  final devCubit = DevCubit(isEnabled: RunMode.isRelease == false);

  final app = RetipApp(
    devCubit: devCubit,
    logger: logger,
    router: router,
    theme: theme,
  );

  logger.info('App started in ${RunMode.name} mode');
  runApp(app);
}
