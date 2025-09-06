import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:retip/app/presentation/cubits/dev/dev_cubit.dart';
import 'package:retip/app/retip_app.dart';
import 'package:retip/core/logger/retip_logger.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/theme/retip_theme.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          ),
  );

  // Dependency injection
  final router = RetipRouter(logger);
  final theme = RetipTheme();

  final devCubit = DevCubit();

  // Assemble final app
  final app = RetipApp(
    locale: locale.isNotEmpty ? Locale(locale.toLowerCase()) : null,
    devCubit: devCubit,
    logger: logger,
    router: router,
    theme: theme,
  );

  runApp(app);

  logger.info('App started');
}
