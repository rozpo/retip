import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/l10n/retip_l10n.dart';
import '../core/router/retip_router.dart';
import '../core/theme/retip_theme.dart';
import 'domain/usecases/album_usecase.dart';
import 'domain/usecases/artist_usecase.dart';
import 'domain/usecases/config_usecase.dart';
import 'domain/usecases/genre_usecase.dart';
import 'domain/usecases/library_usecase.dart';
import 'domain/usecases/permission_usecase.dart';
import 'domain/usecases/track_usecase.dart';
import 'presentation/pages/library/bloc/library_bloc.dart';
import 'presentation/pages/permission/bloc/permission_bloc.dart';

class RetipApp extends StatelessWidget {
  final RetipRouter retipRouter;
  final RetipTheme retipTheme;

  final PermissionUsecase permissionUsecase;
  final LibraryUsecase libraryUsecase;
  final ArtistUsecase artistUsecase;
  final ConfigUsecase configUsecase;
  final AlbumUsecase albumUsecase;
  final GenreUsecase genreUsecase;
  final TrackUsecase trackUsecase;

  final PermissionBloc permissionBloc;
  final LibraryBloc libraryBloc;

  const RetipApp({
    required this.permissionUsecase,
    required this.libraryUsecase,
    required this.permissionBloc,
    required this.artistUsecase,
    required this.configUsecase,
    required this.albumUsecase,
    required this.genreUsecase,
    required this.trackUsecase,
    required this.libraryBloc,
    required this.retipRouter,
    required this.retipTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => permissionUsecase),
        RepositoryProvider(create: (_) => libraryUsecase),
        RepositoryProvider(create: (_) => artistUsecase),
        RepositoryProvider(create: (_) => configUsecase),
        RepositoryProvider(create: (_) => albumUsecase),
        RepositoryProvider(create: (_) => genreUsecase),
        RepositoryProvider(create: (_) => trackUsecase),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => permissionBloc),
          BlocProvider(create: (_) => libraryBloc),
        ],
        child: MaterialApp.router(
          localizationsDelegates: RetipL10n.localizationsDelegates,
          supportedLocales: RetipL10n.supportedLocales,
          scrollBehavior: retipTheme.scrollBehavior,
          darkTheme: retipTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: retipRouter,
          theme: ThemeData.light(),
        ),
      ),
    );
  }
}
