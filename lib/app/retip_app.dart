import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/data/providers/retip_config.dart';
import 'package:retip/app/presentation/library/bloc/library_bloc.dart';
import 'package:retip/app/presentation/tracks/bloc/tracks_bloc.dart';
import 'package:retip/app/services/repositories/audio_repository.dart';
import 'package:retip/app/services/repositories/theme_repository.dart';
import 'package:retip/app/views/favourites/bloc/favourites_bloc.dart';
import 'package:retip/app/views/settings/cubit/settings_cubit.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  final AudioRepository audioRepository;
  final ThemeRepository themeRepository;

  const RetipApp({
    required this.audioRepository,
    required this.themeRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Show additional debug info about UI
    debugRepaintRainbowEnabled =
        RetipConfig.getBool(RetipConfigBoolKey.debugRepaintRainbowEnabled);
    debugInvertOversizedImages =
        RetipConfig.getBool(RetipConfigBoolKey.debugInvertOversizedImages);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => audioRepository),
        RepositoryProvider(create: (_) => themeRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) {
            return SettingsCubit(
              audioRepository: audioRepository,
              themeRepository: themeRepository,
            );
          }),
          BlocProvider(create: (_) {
            return TracksBloc()..add(FetchTracksEvent());
          }),
          BlocProvider(create: (_) => LibraryBloc()),
          BlocProvider(create: (_) => FavouritesBloc()),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: RetipConfig.getBool(
                  RetipConfigBoolKey.debugShowCheckedModeBanner),
              showPerformanceOverlay: RetipConfig.getBool(
                  RetipConfigBoolKey.showPerformanceOverlay),
              themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
              theme: RetipTheme.light(state.themeColor),
              darkTheme: RetipTheme.dark(state.themeColor),
              highContrastTheme: RetipTheme.contrastLight,
              highContrastDarkTheme: RetipTheme.contrastDark,
              localizationsDelegates: RetipL10n.localizationsDelegates,
              supportedLocales: RetipL10n.supportedLocales,
              routerConfig: RetipRouter.router,
            );
          },
        ),
      ),
    );
  }
}
