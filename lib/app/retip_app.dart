import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/cubits/dev/dev_cubit.dart';
import 'package:retip/core/logger/retip_logger.dart';

import '../core/router/retip_router.dart';
import '../core/theme/retip_theme.dart';
import 'presentation/cubits/settings/settings_cubit.dart';

class RetipApp extends StatelessWidget {
  final RetipLogger logger;
  final RetipRouter router;
  final RetipTheme theme;

  final DevCubit devCubit;

  const RetipApp({
    required this.logger,
    required this.router,
    required this.theme,
    required this.devCubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return logger.wrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => devCubit),
          BlocProvider(create: (context) => SettingsCubit()),
        ],
        child: BlocBuilder<DevCubit, DevState>(
          bloc: context.read(),
          builder: (context, state) {
            bool debugShowCheckedModeBanner = false;
            bool showPerformanceOverlay = false;

            if (state is DevEnabled) {
              debugShowCheckedModeBanner = state.debugShowCheckedModeBanner;
              showPerformanceOverlay = state.showPerformanceOverlay;

              debugRepaintTextRainbowEnabled =
                  state.debugRepaintTextRainbowEnabled;
              debugPaintLayerBordersEnabled =
                  state.debugPaintLayerBordersEnabled;
              debugInvertOversizedImages = state.debugInvertedOversizedImages;
              debugPaintBaselinesEnabled = state.debugPaintBaselinesEnabled;
              debugRepaintRainbowEnabled = state.debugRepaintRainbowEnabled;
              debugPaintPointersEnabled = state.debugPaintPointersEnabled;
              debugPaintSizeEnabled = state.debugPaintSizeEnabled;
            } else {
              debugRepaintTextRainbowEnabled = false;
              debugPaintLayerBordersEnabled = false;
              debugInvertOversizedImages = false;
              debugPaintBaselinesEnabled = false;
              debugRepaintRainbowEnabled = false;
              debugPaintPointersEnabled = false;
              debugPaintSizeEnabled = false;
            }

            return BlocBuilder<SettingsCubit, SettingsState>(
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
