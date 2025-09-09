import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/blocs/artist/artist_bloc.dart';
import 'package:retip/app/presentation/blocs/track/track_bloc.dart';
import 'package:retip/app/presentation/cubits/app_info/app_info_cubit.dart';
import 'package:retip/app/presentation/cubits/dev/dev_cubit.dart';
import 'package:retip/app/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:retip/app/presentation/cubits/permissions/permissions_cubit.dart';
import 'package:retip/app/presentation/cubits/theme/theme_cubit.dart';

import '../core/l10n/retip_l10n.dart';
import '../core/logger/retip_logger.dart';
import '../core/router/retip_router.dart';
import '../core/theme/retip_theme.dart';
import 'presentation/blocs/album/album_bloc.dart';

class RetipApp extends StatelessWidget {
  final PermissionsCubit permissionsCubit;
  final OnboardingCubit onboardingCubit;
  final AppInfoCubit appInfoCubit;
  final ArtistBloc artistBloc;
  final ThemeCubit themeCubit;
  final AlbumBloc albumBloc;
  final TrackBloc trackBloc;
  final RetipLogger logger;
  final RetipRouter router;
  final DevCubit devCubit;
  final RetipTheme theme;

  final Locale? locale;

  const RetipApp({
    required this.permissionsCubit,
    required this.onboardingCubit,
    required this.appInfoCubit,
    required this.artistBloc,
    required this.themeCubit,
    required this.albumBloc,
    required this.trackBloc,
    required this.devCubit,
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: permissionsCubit),
          BlocProvider.value(value: onboardingCubit),
          BlocProvider.value(value: appInfoCubit),
          BlocProvider.value(value: artistBloc),
          BlocProvider.value(value: themeCubit),
          BlocProvider.value(value: albumBloc),
          BlocProvider.value(value: trackBloc),
          BlocProvider.value(value: devCubit),
        ],
        child: BlocBuilder<DevCubit, DevState>(
          builder: (context, state) {
            final showPerformanceOverlay = state.showPerformanceOverlay;
            debugInvertOversizedImages = state.invertOversizedImages;
            debugRepaintRainbowEnabled = state.repaintRainbowEnabled;

            return BlocBuilder<ThemeCubit, ThemeState>(
              bloc: context.read<ThemeCubit>(),
              builder: (context, state) {
                return MaterialApp.router(
                  localizationsDelegates: RetipL10n.localizationsDelegates,
                  showPerformanceOverlay: showPerformanceOverlay,
                  supportedLocales: RetipL10n.supportedLocales,
                  darkTheme: theme.dark(state.seedColor),
                  theme: theme.light(state.seedColor),
                  themeMode: state.themeMode,
                  routerConfig: router,
                  locale: locale,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
