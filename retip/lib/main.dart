import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/data/providers/package_info_provider.dart';
import 'package:retip/app/data/repositories/album_repository_i.dart';
import 'package:retip/app/data/repositories/app_info_repository_i.dart';
import 'package:retip/app/data/repositories/permissions_repository_i.dart';
import 'package:retip/app/data/repositories/track_repository_i.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/presentation/blocs/track/track_bloc.dart';
import 'package:retip/app/presentation/cubits/app_info/app_info_cubit.dart';
import 'package:retip/app/presentation/cubits/dev/dev_cubit.dart';
import 'package:retip/app/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:retip/app/presentation/cubits/permissions/permissions_cubit.dart';
import 'package:retip/app/presentation/cubits/theme/theme_cubit.dart';
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
  final packageInfoProvider = await PackageInfoProvider.init();
  final onAudioQueryProvider = await OnAudioQueryProvider.init();

  final appInfoRepository = AppInfoRepositoryI(packageInfoProvider);

  final permissionsRepository = PermissionsRepositoryI(onAudioQueryProvider);
  final trackRepository = TrackRepositoryI(onAudioQueryProvider);
  final albumRepository = AlbumRepositoryI(onAudioQueryProvider);

  final router = RetipRouter(logger);
  final theme = RetipTheme();

  final result = await permissionsRepository.permissionsCheck();
  final isGranted = result is ResultSuccess<bool> ? result.data : false;

  final permissionsCubit = PermissionsCubit(
    permissionsRepository: permissionsRepository,
    isGranted: isGranted,
  );

  final onboardingCubit = OnboardingCubit();
  final themeCubit = ThemeCubit();
  final devCubit = DevCubit();

  final appInfoCubit = AppInfoCubit(appInfoRepository);
  final trackBloc = TrackBloc(trackRepository);

  // Assemble final app
  final app = RetipApp(
    trackBloc: trackBloc,
    locale: locale.isNotEmpty ? Locale(locale.toLowerCase()) : null,
    permissionsCubit: permissionsCubit,
    onboardingCubit: onboardingCubit,
    appInfoCubit: appInfoCubit,
    themeCubit: themeCubit,
    devCubit: devCubit,
    logger: logger,
    router: router,
    theme: theme,
  );

  runApp(app);

  logger.info('App started');
}
