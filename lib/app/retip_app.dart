import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/cubits/dev/dev_cubit.dart';
import 'package:retip/core/logger/retip_logger.dart';

import '../core/router/retip_router.dart';
import '../core/theme/retip_theme.dart';
import 'presentation/cubits/theme/theme_cubit.dart';

class RetipApp extends StatelessWidget {
  final RetipLogger logger;
  final RetipRouter router;
  final RetipTheme theme;

  const RetipApp({
    required this.logger,
    required this.router,
    required this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return logger.wrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DevCubit()),
          BlocProvider(create: (context) => ThemeCubit()),
        ],
        child: BlocBuilder<DevCubit, DevState>(
          bloc: context.read(),
          builder: (context, state) {
            bool debugShowCheckedModeBanner = false;
            bool showPerformanceOverlay = false;

            if (state is DevEnabled) {
              debugRepaintTextRainbowEnabled = state.debugRepaintRainbowEnabled;
              debugInvertOversizedImages = state.debugInvertedOversizedImages;
              debugShowCheckedModeBanner = state.debugShowCheckedModeBanner;
              showPerformanceOverlay = state.showPerformanceOverlay;
            }

            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                  showPerformanceOverlay: showPerformanceOverlay,
                  themeMode: state.themeMode,
                  darkTheme: theme.dark,
                  routerConfig: router,
                  theme: theme.light,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
