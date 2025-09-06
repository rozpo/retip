import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/cubits/dev/dev_cubit.dart';
import 'package:retip/app/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:retip/app/presentation/cubits/permissions/permissions_cubit.dart';

import '../core/l10n/retip_l10n.dart';
import '../core/logger/retip_logger.dart';
import '../core/router/retip_router.dart';
import '../core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  final PermissionsCubit permissionsCubit;
  final OnboardingCubit onboardingCubit;
  final RetipLogger logger;
  final RetipRouter router;
  final DevCubit devCubit;
  final RetipTheme theme;

  final Locale? locale;

  const RetipApp({
    required this.permissionsCubit,
    required this.onboardingCubit,
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
          BlocProvider.value(value: devCubit),
        ],
        child: BlocBuilder<DevCubit, DevState>(
          builder: (context, state) {
            debugInvertOversizedImages = state.invertOversizedImages;
            debugRepaintRainbowEnabled = state.repaintRainbowEnabled;

            return MaterialApp.router(
              localizationsDelegates: RetipL10n.localizationsDelegates,
              showPerformanceOverlay: state.showPerformanceOverlay,
              supportedLocales: RetipL10n.supportedLocales,
              themeMode: ThemeMode.system,
              darkTheme: theme.dark,
              routerConfig: router,
              theme: theme.light,
              locale: locale,
            );
          },
        ),
      ),
    );
  }
}
