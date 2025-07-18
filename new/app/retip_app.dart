import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router/retip_router.dart';
import 'domain/services/album_service.dart';
import 'domain/services/playlist_service.dart';
import 'presentation/blocs/audio/audio_bloc.dart';
import 'presentation/blocs/library/library_bloc.dart';
import 'presentation/blocs/onboarding/onboarding_bloc.dart';
import 'presentation/blocs/permissions/permissions_bloc.dart';

class RetipApp extends StatelessWidget {
  final PermissionsBloc permissionsBloc;
  final PlaylistService playlistService;
  final OnboardingBloc onboardingBloc;
  final AlbumService albumService;
  final LibraryBloc libraryBloc;
  final AudioBloc audioBloc;
  final RetipRouter router;

  const RetipApp({
    required this.permissionsBloc,
    required this.playlistService,
    required this.onboardingBloc,
    required this.albumService,
    required this.libraryBloc,
    required this.audioBloc,
    required this.router,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create:(context) => playlistService),
        RepositoryProvider(create:(context) => albumService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => permissionsBloc),
          BlocProvider(create: (context) => onboardingBloc),
          BlocProvider(create: (context) => libraryBloc),
          BlocProvider(create: (context) => audioBloc),
        ],
        child: MaterialApp.router(
          themeMode: ThemeMode.system,
          darkTheme: ThemeData.dark(),
          theme: ThemeData.light(),
          routerConfig: router,
        ),
      ),
    );
  }
}
