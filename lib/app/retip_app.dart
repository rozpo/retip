import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/l10n/retip_l10n.dart';
import '../core/router/retip_router.dart';
import '../core/theme/retip_theme.dart';
import 'domain/repositories/config_repository.dart';
import 'domain/repositories/permission_repository.dart';
import 'domain/repositories/settings_repository.dart';
import 'presentation/blocs/album/album_bloc.dart';
import 'presentation/blocs/artist/artist_bloc.dart';
import 'presentation/blocs/audio/audio_bloc.dart';
import 'presentation/blocs/track/track_bloc.dart';
import 'presentation/cubits/library/library_cubit.dart';
import 'presentation/cubits/onboarding/onboarding_cubit.dart';
import 'presentation/cubits/permission/permission_cubit.dart';

class RetipApp extends StatelessWidget {
  final PermissionRepository permissionRepository;
  final SettingsRepository settingsRepository;
  final ConfigRepository configRepository;
  final OnboardingCubit onboardingCubit;
  final PermissionCubit permissionCubit;
  final LibraryCubit libraryCubit;
  final ArtistBloc artistBloc;
  final AudioBloc audioBloc;
  final TrackBloc trackBloc;
  final AlbumBloc albumBloc;
  final RetipRouter router;
  final RetipTheme theme;
  final RetipL10n l10n;

  const RetipApp({
    required this.permissionRepository,
    required this.settingsRepository,
    required this.configRepository,
    required this.onboardingCubit,
    required this.permissionCubit,
    required this.libraryCubit,
    required this.artistBloc,
    required this.audioBloc,
    required this.albumBloc,
    required this.trackBloc,
    required this.router,
    required this.theme,
    required this.l10n,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => l10n),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => permissionRepository),
          RepositoryProvider(create: (context) => settingsRepository),
          RepositoryProvider(create: (context) => configRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => onboardingCubit),
            BlocProvider(create: (context) => permissionCubit),
            BlocProvider(create: (context) => libraryCubit),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => artistBloc),
              BlocProvider(create: (context) => audioBloc),
              BlocProvider(create: (context) => albumBloc),
              BlocProvider(create: (context) => trackBloc),
            ],
            child: MaterialApp.router(
              localizationsDelegates: l10n.localizationsDelegates,
              supportedLocales: l10n.supportedLocales,
              scrollBehavior: theme.scrollBehavior,
              themeMode: ThemeMode.system,
              darkTheme: theme.dark(),
              theme: theme.light(),
              routerConfig: router,
            ),
          ),
        ),
      ),
    );
  }
}
