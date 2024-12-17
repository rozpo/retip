import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/views/settings/cubit/settings_cubit.dart';
import 'package:retip/core/config/retip_config.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  const RetipApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Show additional debug info about UI
    debugRepaintRainbowEnabled =
        RetipConfig.getBool(RetipConfigBoolKey.debugRepaintRainbowEnabled);
    debugInvertOversizedImages =
        RetipConfig.getBool(RetipConfigBoolKey.debugInvertOversizedImages);

    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: RetipConfig.getBool(
                RetipConfigBoolKey.debugShowCheckedModeBanner),
            showPerformanceOverlay:
                RetipConfig.getBool(RetipConfigBoolKey.showPerformanceOverlay),
            themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
            theme: RetipTheme.light,
            darkTheme: RetipTheme.dark,
            highContrastTheme: RetipTheme.contrastLight,
            highContrastDarkTheme: RetipTheme.contrastDark,
            localizationsDelegates: RetipL10n.localizationsDelegates,
            supportedLocales: RetipL10n.supportedLocales,
            routerConfig: RetipRouter.router,
          );
        },
      ),
    );
  }
}
